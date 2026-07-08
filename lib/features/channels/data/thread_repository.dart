import 'package:dio/dio.dart';
import 'package:fluxer_app/core/database/fluxer_database.dart' as db;
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/shared/utils/sdk_converters.dart';
import 'package:fluxer_dart/export.dart';

/// Echowire: create, list, and moderate threads + forum posts.
///
/// `parentChannelId` is the text/forum channel a thread lives under;
/// `threadId` is the thread channel itself. A thread IS a channel, so results
/// are cached into the same `channels` table and returned as [Channel]s.
class ThreadRepository {
  final FluxerClient _client;
  final db.FluxerDatabase _db;

  const ThreadRepository(this._client, this._db);

  /// Watch the cached thread/forum-post channels under [parentChannelId],
  /// reacting to gateway inserts/updates so new posts appear without a refetch.
  Stream<List<Channel>> watchThreads(String parentChannelId) {
    return _db.channelDao
        .watchThreadsForParent(parentChannelId)
        .map((List<db.Channel> rows) => rows.map(Channel.fromRow).toList());
  }

  /// Watch active (non-archived) threads across the whole guild, for nesting
  /// under their parent channel in the sidebar.
  Stream<List<Channel>> watchGuildThreads(String guildId) {
    return _db.channelDao
        .watchActiveThreadsForGuild(guildId)
        .map((List<db.Channel> rows) => rows.map(Channel.fromRow).toList());
  }

  /// Fetch active + archived threads from the API to populate/refresh the cache.
  Future<void> refreshThreads(String parentChannelId, {String? guildId}) async {
    await listActiveThreads(parentChannelId, guildId: guildId);
    await listArchivedThreads(parentChannelId, guildId: guildId);
  }

  Future<Channel> _cacheAndReturn(
    ChannelResponse resp, {
    String? fallbackGuildId,
  }) async {
    final String guildId = resp.guildId ?? fallbackGuildId ?? '';
    await _db.channelDao.upsertChannel(channelFromSdk(resp, guildId));
    final db.Channel? row = await _db.channelDao.getChannelById(resp.id);
    return Channel.fromRow(row!);
  }

  Future<List<Channel>> _cacheAndReturnAll(
    List<ChannelResponse> list, {
    String? fallbackGuildId,
  }) async {
    await _db.channelDao.upsertChannels(
      list
          .map(
            (ChannelResponse c) =>
                channelFromSdk(c, c.guildId ?? fallbackGuildId ?? ''),
          )
          .toList(),
    );
    final List<Channel> result = <Channel>[];
    for (final ChannelResponse c in list) {
      final db.Channel? row = await _db.channelDao.getChannelById(c.id);
      if (row != null) {
        result.add(Channel.fromRow(row));
      }
    }
    return result;
  }

  /// Create a thread (or forum post) under [parentChannelId]. Pass [messageId]
  /// to start it from an existing message; [appliedTags] for forum posts.
  Future<Channel> createThread({
    required String parentChannelId,
    required String name,
    String? messageId,
    List<String>? appliedTags,
    int? autoArchiveDuration,
    ChannelType type = ChannelType.publicThread,
  }) async {
    try {
      final ChannelResponse resp = await _client.channels.createThread(
        channelId: parentChannelId,
        body: ThreadCreateRequest(
          name: name,
          messageId: messageId,
          appliedTags: appliedTags,
          autoArchiveDuration: autoArchiveDuration,
          type: type.wireValue,
        ),
      );
      return _cacheAndReturn(resp);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to create thread');
    }
  }

  Future<List<Channel>> listActiveThreads(
    String parentChannelId, {
    String? guildId,
  }) async {
    try {
      final List<ChannelResponse> resp = await _client.channels
          .listActiveThreads(channelId: parentChannelId);
      return _cacheAndReturnAll(resp, fallbackGuildId: guildId);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to list threads');
    }
  }

  Future<List<Channel>> listArchivedThreads(
    String parentChannelId, {
    String? guildId,
  }) async {
    try {
      final List<ChannelResponse> resp = await _client.channels
          .listArchivedThreads(channelId: parentChannelId);
      return _cacheAndReturnAll(resp, fallbackGuildId: guildId);
    } on DioException catch (e) {
      throw Exception(
        e.response?.statusMessage ?? 'Failed to list archived threads',
      );
    }
  }

  /// Update thread state: archive/unarchive, lock, pin, rename, retag, etc.
  Future<Channel> updateThread(
    String threadId, {
    String? name,
    bool? archived,
    bool? locked,
    bool? pinned,
    bool? invitable,
    int? autoArchiveDuration,
    List<String>? appliedTags,
  }) async {
    try {
      final ChannelResponse resp = await _client.channels.updateThread(
        channelId: threadId,
        body: ThreadUpdateRequest(
          name: name,
          archived: archived,
          locked: locked,
          pinned: pinned,
          invitable: invitable,
          autoArchiveDuration: autoArchiveDuration,
          appliedTags: appliedTags,
        ),
      );
      return _cacheAndReturn(resp);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to update thread');
    }
  }

  Future<void> deleteThread(String threadId) async {
    try {
      await _client.channels.deleteThread(channelId: threadId);
      await _db.channelDao.deleteChannel(threadId);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to delete thread');
    }
  }

  /// List the user IDs of a thread's members.
  Future<List<String>> listThreadMemberIds(String threadId) async {
    try {
      final List<ThreadMemberResponse> resp = await _client.channels
          .listThreadMembers(channelId: threadId);
      return resp.map((ThreadMemberResponse m) => m.userId).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.statusMessage ?? 'Failed to load thread members',
      );
    }
  }

  Future<void> joinThread(String threadId) async {
    try {
      await _client.channels.joinThread(channelId: threadId);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to join thread');
    }
  }

  Future<void> leaveThread(String threadId) async {
    try {
      await _client.channels.leaveThread(channelId: threadId);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to leave thread');
    }
  }
}
