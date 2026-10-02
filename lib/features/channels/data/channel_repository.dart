import 'package:dio/dio.dart';
import 'package:fluxer_app/core/database/fluxer_database.dart' as db;
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/domain/channel_move_operation.dart';
import 'package:fluxer_app/features/channels/domain/channel_move_payload.dart';
import 'package:fluxer_app/features/channels/domain/channel_overview_update.dart';
import 'package:fluxer_app/features/channels/domain/channel_permission_overwrite_update.dart';
import 'package:fluxer_app/features/channels/domain/forum_view.dart';
import 'package:fluxer_app/shared/utils/sdk_converters.dart';
import 'package:fluxer_dart/export.dart' hide ChannelType;

class ChannelRepository {
  final FluxerClient _client;
  final Dio _dio;
  final db.FluxerDatabase _db;

  const ChannelRepository(this._client, this._dio, this._db);

  /// Emits only when the domain channels change, not on tail-pointer writes.
  Stream<List<Channel>> watchChannels(String guildId) {
    return _db.channelDao
        .watchChannels(guildId)
        .map((rows) => rows.map(Channel.fromRow).toList())
        .distinct(_sameExceptPointers);
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

  /// Echowire: fetch one channel by id and cache it. A session payload carries
  /// a guild's open channels and open threads, never its archived ones, so a
  /// link straight to an archived forum post names an id this database has not
  /// seen. Returns null when the channel is gone, is not visible to this user,
  /// or is not a guild channel.
  Future<Channel?> fetchChannelById(String channelId) async {
    if (channelId.isEmpty) {
      return null;
    }
    try {
      final ChannelResponse response = await _client.channels.getChannel(
        channelId: channelId,
      );
      final String? guildId = response.guildId;
      if (guildId == null) {
        return null;
      }
      await _db.channelDao.upsertChannels(<db.ChannelsCompanion>[
        channelFromSdk(response, guildId),
      ]);
      final db.Channel? row = await _db.channelDao.getChannelById(channelId);
      return row == null ? null : Channel.fromRow(row);
    } on DioException {
      return null;
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
    final ChannelUpdateRequestBodyVariant1 body =
        buildChannelPermissionOverwritesUpdate(
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
    ChannelUpdateRequestBodyVariant1 body,
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
    } on DioException {
      rethrow;
    }
  }

  Future<ChannelFollowerStatsResponse> getFollowerStats(String channelId) {
    return _client.channels.getChannelFollowerStats(channelId: channelId);
  }

  Future<FollowedChannelResponse> followAnnouncementChannel({
    required String channelId,
    required String webhookChannelId,
  }) {
    return _client.channels.followChannel(
      channelId: channelId,
      body: ChannelFollowRequest(webhookChannelId: webhookChannelId),
    );
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

/// Echowire: upstream compares with listEquals, which relies on Channel.==
/// ignoring lastMessageId. This fork keeps the pointer in == and exposes
/// sameExceptLastMessage, so the channel list uses that to ignore
/// pointer-only writes without changing equality for other consumers.
bool _sameExceptPointers(List<Channel> a, List<Channel> b) {
  if (a.length != b.length) {
    return false;
  }
  for (int i = 0; i < a.length; i++) {
    if (!a[i].sameExceptLastMessage(b[i])) {
      return false;
    }
  }
  return true;
}
