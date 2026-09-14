import 'package:dio/dio.dart';
import 'package:fluxer_app/core/database/fluxer_database.dart' as db;
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/domain/channel_move_operation.dart';
import 'package:fluxer_app/features/channels/domain/channel_move_payload.dart';
import 'package:fluxer_app/features/channels/domain/channel_overview_update.dart';
import 'package:fluxer_app/features/channels/domain/channel_permission_overwrite_update.dart';
import 'package:fluxer_app/features/channels/domain/forum_view.dart';
import 'package:fluxer_app/shared/utils/sdk_converters.dart';
import 'package:fluxer_dart/export.dart';

class ChannelRepository {
  final FluxerClient _client;
  final Dio _dio;
  final db.FluxerDatabase _db;

  const ChannelRepository(this._client, this._dio, this._db);

  Stream<List<Channel>> watchChannels(String guildId) {
    return _db.channelDao
        .watchChannels(guildId)
        .map((rows) => rows.map(Channel.fromRow).toList());
  }

  Future<List<ChannelCategory>> getChannels(String guildId) async {
    try {
      final channels = await _client.guilds.listGuildChannels(guildId: guildId);

      final companions = channels
          .map((ch) => channelFromSdk(ch, guildId))
          .toList();
      await _db.channelDao.upsertChannels(companions);

      final rows = await _db.channelDao.getChannels(guildId);
      final channelList = rows.map(Channel.fromRow).toList();
      return groupChannelsIntoCategories(channelList);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to fetch channels');
    }
  }

  Future<void> applyLocalChannels(
    String guildId,
    List<Channel> channels,
  ) async {
    await _db.channelDao.upsertChannels(
      channels.map((Channel channel) => channel.toCompanion()).toList(),
    );
  }

  Future<Channel> updateChannelOverview({
    required Channel channel,
    required ChannelOverviewFormState current,
    required ChannelOverviewFormState original,
    required bool canManageChannel,
    required bool canUpdateRtcRegion,
  }) {
    final Map<String, dynamic> body = buildChannelOverviewPatchBody(
      channel: channel,
      current: current,
      original: original,
      canManageChannel: canManageChannel,
      canUpdateRtcRegion: canUpdateRtcRegion,
    );
    return _patchChannelBody(channel.id, channel.guildId, body);
  }

  Future<Channel> updateChannelPermissionOverwrites({
    required Channel channel,
    required List<ChannelPermissionOverwriteEntry> overwrites,
  }) {
    final ChannelUpdateRequest body = buildChannelPermissionOverwritesUpdate(
      channel: channel,
      overwrites: overwrites,
    );
    return _patchChannel(channel.id, channel.guildId, body);
  }

  Future<List<RtcRegionResponse>> listRtcRegions(String channelId) async {
    try {
      return await _client.channels.listRtcRegions(channelId: channelId);
    } on DioException catch (e) {
      throw Exception(
        e.response?.statusMessage ?? 'Failed to fetch voice regions',
      );
    }
  }

  Future<ChannelSlowmodeStateResponse> getSlowmodeState(String channelId) {
    return _client.channels.getChannelSlowmodeState(channelId: channelId);
  }

  /// Echowire: replace a forum channel's full set of available tags. Each entry
  /// is `{name, id?, emoji_name?}`; omit `id` to create a new tag. The generated
  /// SDK has no forum variant of the channel update request, so this sends the
  /// forum body directly.
  Future<Channel> updateForumTags({
    required String forumId,
    required String guildId,
    required List<Map<String, Object?>> tags,
  }) {
    return _patchChannelBody(forumId, guildId, <String, dynamic>{
      'type': ChannelType.guildForum.wireValue,
      'available_tags': tags,
    });
  }

  /// Echowire: update forum settings (any subset of `topic` as guidelines,
  /// `require_tag`, `default_sort_order`, `default_forum_layout`,
  /// `default_reaction_emoji`, `default_auto_archive_duration`,
  /// `rate_limit_per_user` and `default_thread_rate_limit_per_user`). Returns
  /// the updated channel and the forum fields the SDK does not model.
  Future<({Channel channel, ForumExtras extras})> updateForumSettings({
    required String forumId,
    required String guildId,
    required Map<String, Object?> fields,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await _dio
          .patch<Map<String, dynamic>>(
            '/channels/$forumId',
            data: <String, Object?>{
              'type': ChannelType.guildForum.wireValue,
              ...fields,
            },
          );
      final Map<String, dynamic>? data = response.data;
      if (data == null) {
        throw Exception('Failed to update forum');
      }
      await _db.channelDao.upsertChannels(<db.ChannelsCompanion>[
        channelFromSdk(ChannelResponse.fromJson(data), guildId),
      ]);
      final db.Channel? row = await _db.channelDao.getChannelById(forumId);
      if (row == null) {
        throw Exception('Failed to load updated forum');
      }
      return (
        channel: Channel.fromRow(row),
        extras: ForumExtras.fromChannelJson(data),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to update forum');
    }
  }

  Future<Channel> _patchChannel(
    String channelId,
    String guildId,
    ChannelUpdateRequest body,
  ) {
    return _patchChannelBody(
      channelId,
      guildId,
      channelUpdateRequestToPatchBody(body),
    );
  }

  Future<Channel> _patchChannelBody(
    String channelId,
    String guildId,
    Map<String, dynamic> body,
  ) async {
    try {
      final Response<Map<String, dynamic>> response = await _dio
          .patch<Map<String, dynamic>>('/channels/$channelId', data: body);
      final Map<String, dynamic>? data = response.data;
      if (data == null) {
        throw Exception('Failed to update channel');
      }
      final ChannelResponse channelResponse = ChannelResponse.fromJson(data);
      final db.ChannelsCompanion companion = channelFromSdk(
        channelResponse,
        guildId,
      );
      await _db.channelDao.upsertChannels(<db.ChannelsCompanion>[companion]);
      final db.Channel? row = await _db.channelDao.getChannelById(channelId);
      if (row == null) {
        throw Exception('Failed to load updated channel');
      }
      return Channel.fromRow(row);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to update channel');
    }
  }

  Future<void> moveChannel({
    required String guildId,
    required ChannelMoveOperation operation,
    List<Channel>? rollbackChannels,
  }) async {
    try {
      await _dio.patch<void>(
        '/guilds/$guildId/channels',
        data: buildChannelMoveRequestBody(operation),
      );
    } on DioException catch (e) {
      if (rollbackChannels != null) {
        await applyLocalChannels(guildId, rollbackChannels);
      }
      throw Exception(e.response?.statusMessage ?? 'Failed to move channel');
    }
  }
}
