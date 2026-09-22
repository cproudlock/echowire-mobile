import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluxer_app/core/database/fluxer_database.dart' as db;
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/domain/forum_view.dart';
import 'package:fluxer_app/shared/utils/sdk_converters.dart';
import 'package:fluxer_dart/export.dart' hide ChannelType;

/// Echowire: create, list, and moderate threads + forum posts.
///
/// `parentChannelId` is the text/forum channel a thread lives under;
/// `threadId` is the thread channel itself. A thread IS a channel, so results
/// are cached into the same `channels` table and returned as [Channel]s.
///
/// Thread list endpoints are read as raw JSON so the fields the server adds on
/// top of the generated SDK (the starter message preview, forum layout) are not
/// dropped. Those live in memory in [starterPreviews], [memberships] and
/// [forumExtras]; they refill on the next list call after a restart.
class ThreadRepository {
  ThreadRepository(this._client, this._dio, this._db);

  final FluxerClient _client;
  final Dio _dio;
  final db.FluxerDatabase _db;

  /// Starter message previews keyed by thread id.
  final ValueNotifier<Map<String, ThreadStarterPreview>> starterPreviews =
      ValueNotifier<Map<String, ThreadStarterPreview>>(
        const <String, ThreadStarterPreview>{},
      );

  /// The current user's known membership per thread id.
  final ValueNotifier<Map<String, bool>> memberships =
      ValueNotifier<Map<String, bool>>(const <String, bool>{});

  /// Forum fields the SDK does not model yet, keyed by forum id.
  final ValueNotifier<Map<String, ForumExtras>> forumExtras =
      ValueNotifier<Map<String, ForumExtras>>(const <String, ForumExtras>{});

  /// Who has posted in each thread, keyed by thread id. Only populated by
  /// servers that send `participant_ids`.
  final ValueNotifier<Map<String, ThreadParticipants>> participants =
      ValueNotifier<Map<String, ThreadParticipants>>(
        const <String, ThreadParticipants>{},
      );

  /// Whether the server offers `GET /guilds/:id/threads/active`. Cleared after
  /// the first 404 so older servers are not asked again this session.
  bool _guildActiveThreadsSupported = true;

  /// False once the server has answered 404 for the guild threads endpoint.
  bool get guildActiveThreadsSupported => _guildActiveThreadsSupported;

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

  /// Record the current user's membership of [threadId] (from a join, leave,
  /// member list, or gateway event).
  void setMembership(String threadId, {required bool isMember}) {
    if (memberships.value[threadId] == isMember) {
      return;
    }
    memberships.value = <String, bool>{
      ...memberships.value,
      threadId: isMember,
    };
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

  /// Parses a thread list body, keeping each starter message preview.
  List<ChannelResponse> _parseThreadList(Object? data) {
    final Object? threads = data is Map<String, dynamic>
        ? data['threads']
        : data;
    if (threads is! List) {
      return const <ChannelResponse>[];
    }
    final List<ChannelResponse> result = <ChannelResponse>[];
    final Map<String, ThreadStarterPreview> previews =
        <String, ThreadStarterPreview>{...starterPreviews.value};
    final Map<String, ThreadParticipants> posters =
        <String, ThreadParticipants>{...participants.value};
    for (final Object? entry in threads) {
      if (entry is! Map<String, dynamic>) {
        continue;
      }
      final ChannelResponse channel = ChannelResponse.fromJson(entry);
      result.add(channel);
      final ThreadStarterPreview? preview = ThreadStarterPreview.fromJson(
        entry['starter_message_preview'],
      );
      if (preview != null) {
        previews[channel.id] = preview;
      }
      final ThreadParticipants? people = ThreadParticipants.fromThreadJson(
        entry,
      );
      if (people != null) {
        posters[channel.id] = people;
      }
    }
    starterPreviews.value = previews;
    participants.value = posters;
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
      // The server auto-joins the creator.
      setMembership(resp.id, isMember: true);
      return await _cacheAndReturn(resp);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to create thread');
    }
  }

  Future<List<Channel>> listActiveThreads(
    String parentChannelId, {
    String? guildId,
  }) async {
    try {
      final Response<Object?> response = await _dio.get<Object?>(
        // The server serves active threads at `/threads` (the contract doc's
        // `/threads/active` spelling is not a route).
        '/channels/$parentChannelId/threads',
      );
      return await _cacheAndReturnAll(
        _parseThreadList(response.data),
        fallbackGuildId: guildId,
      );
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to list threads');
    }
  }

  Future<List<Channel>> listArchivedThreads(
    String parentChannelId, {
    String? guildId,
  }) async {
    try {
      final Response<Object?> response = await _dio.get<Object?>(
        '/channels/$parentChannelId/threads/archived',
      );
      return await _cacheAndReturnAll(
        _parseThreadList(response.data),
        fallbackGuildId: guildId,
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.statusMessage ?? 'Failed to list archived threads',
      );
    }
  }

  /// Every active thread in [guildId] the user can view, plus which of them
  /// the user has joined. Returns null when the server predates the endpoint.
  Future<List<Channel>?> listGuildActiveThreads(String guildId) async {
    if (!_guildActiveThreadsSupported) {
      return null;
    }
    try {
      final Response<Object?> response = await _dio.get<Object?>(
        '/guilds/$guildId/threads/active',
      );
      final Object? data = response.data;
      final List<ChannelResponse> threads = _parseThreadList(data);
      final Set<String> joined = <String>{};
      final Object? members = data is Map<String, dynamic>
          ? data['members']
          : null;
      if (members is List) {
        for (final Object? m in members) {
          if (m is Map<String, dynamic> && m['id'] is String) {
            joined.add(m['id'] as String);
          }
        }
      }
      memberships.value = <String, bool>{
        ...memberships.value,
        for (final ChannelResponse t in threads) t.id: joined.contains(t.id),
      };
      return await _cacheAndReturnAll(threads, fallbackGuildId: guildId);
    } on DioException catch (e) {
      final int? status = e.response?.statusCode;
      if (status == 404 || status == 405) {
        _guildActiveThreadsSupported = false;
        return null;
      }
      throw Exception(
        e.response?.statusMessage ?? 'Failed to list guild threads',
      );
    }
  }

  /// Append an image from [messageId] to the forum post's starter message, so
  /// it becomes the post's thumbnail (Discord's "Add to Post"). The caller must
  /// own the post or be able to manage the thread, per the forums contract.
  Future<void> addMediaToPost({
    required String threadId,
    required String messageId,
    required String attachmentId,
  }) async {
    await _dio.post<Map<String, dynamic>>(
      '/channels/$threadId/starter-message/attachments',
      data: <String, Object?>{
        'message_id': messageId,
        'attachment_id': attachmentId,
      },
    );
  }

  /// Load forum fields the SDK does not model (layout, post slowmode).
  Future<ForumExtras?> loadForumExtras(String forumId) async {
    try {
      final Response<Map<String, dynamic>> response = await _dio
          .get<Map<String, dynamic>>('/channels/$forumId');
      final Map<String, dynamic>? data = response.data;
      if (data == null) {
        return null;
      }
      final ForumExtras extras = ForumExtras.fromChannelJson(data);
      forumExtras.value = <String, ForumExtras>{
        ...forumExtras.value,
        forumId: extras,
      };
      return extras;
    } on DioException {
      return null;
    }
  }

  /// Remember forum fields returned by a forum PATCH.
  void rememberForumExtras(String forumId, ForumExtras extras) {
    forumExtras.value = <String, ForumExtras>{
      ...forumExtras.value,
      forumId: extras,
    };
  }

  /// Update thread state: archive/unarchive, lock, pin, rename, retag, and a
  /// post's own slowmode.
  ///
  /// Sent as raw JSON rather than through the SDK: `ThreadUpdateRequest` has no
  /// `rate_limit_per_user`, which the server accepts for the owner of an
  /// unlocked thread and for anyone who may manage threads.
  Future<Channel> updateThread(
    String threadId, {
    String? name,
    bool? archived,
    bool? locked,
    bool? pinned,
    bool? invitable,
    int? autoArchiveDuration,
    List<String>? appliedTags,
    int? rateLimitPerUser,
  }) async {
    final Map<String, Object?> body = <String, Object?>{
      'name': ?name,
      'archived': ?archived,
      'locked': ?locked,
      'pinned': ?pinned,
      'invitable': ?invitable,
      'auto_archive_duration': ?autoArchiveDuration,
      'applied_tags': ?appliedTags,
      'rate_limit_per_user': ?rateLimitPerUser,
    };
    try {
      final Response<Map<String, dynamic>> response = await _dio
          .patch<Map<String, dynamic>>(
            '/channels/$threadId/thread',
            data: body,
          );
      final Map<String, dynamic>? data = response.data;
      if (data == null) {
        throw Exception('Failed to update thread');
      }
      return await _cacheAndReturn(ChannelResponse.fromJson(data));
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

  /// Resolve whether [userId] is a member of [threadId] from the member list,
  /// and remember it. Returns null when the list cannot be loaded.
  Future<bool?> loadMembership(String threadId, String userId) async {
    try {
      final List<String> ids = await listThreadMemberIds(threadId);
      final bool isMember = ids.contains(userId);
      setMembership(threadId, isMember: isMember);
      return isMember;
    } on Exception {
      return null;
    }
  }

  final Set<String> _membershipRequests = <String>{};

  /// Load membership for [threadId] once per session when it is still unknown.
  void ensureMembershipLoaded(String threadId, String? userId) {
    if (userId == null ||
        memberships.value.containsKey(threadId) ||
        !_membershipRequests.add(threadId)) {
      return;
    }
    loadMembership(threadId, userId).whenComplete(() {
      _membershipRequests.remove(threadId);
    }).ignore();
  }

  Future<void> joinThread(String threadId) async {
    try {
      await _client.channels.joinThread(channelId: threadId);
      setMembership(threadId, isMember: true);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to join thread');
    }
  }

  Future<void> leaveThread(String threadId) async {
    try {
      await _client.channels.leaveThread(channelId: threadId);
      setMembership(threadId, isMember: false);
    } on DioException catch (e) {
      throw Exception(e.response?.statusMessage ?? 'Failed to leave thread');
    }
  }

  /// Add [userId] to [threadId].
  ///
  /// Raw JSON: the SDK models only the `@me` join and leave routes. The server
  /// allows the thread owner and anyone who may manage threads, plus any member
  /// when the thread is invitable, and answers 404 when the target cannot see
  /// the parent channel.
  Future<void> addThreadMember(String threadId, String userId) async {
    try {
      await _dio.put<void>('/channels/$threadId/thread-members/$userId');
    } on DioException catch (e) {
      throw ThreadMemberException.fromDioException(e);
    }
  }

  /// Remove [userId] from [threadId]. Removing yourself is leaving.
  Future<void> removeThreadMember(String threadId, String userId) async {
    try {
      await _dio.delete<void>('/channels/$threadId/thread-members/$userId');
    } on DioException catch (e) {
      throw ThreadMemberException.fromDioException(e);
    }
  }

  /// Whether [userId] is a member of [threadId], asked of the server directly.
  /// Returns false on 404, which is how the server reports "not a member".
  Future<bool> fetchThreadMember(String threadId, String userId) async {
    try {
      await _dio.get<Map<String, dynamic>>(
        '/channels/$threadId/thread-members/$userId',
      );
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return false;
      }
      throw ThreadMemberException.fromDioException(e);
    }
  }
}

/// Why a thread membership change failed, so the UI can say something useful
/// rather than surfacing a status line.
enum ThreadMemberFailure { full, notFound, forbidden, unknown }

class ThreadMemberException implements Exception {
  const ThreadMemberException(this.failure);

  final ThreadMemberFailure failure;

  /// The server returns its member cap as a 400 carrying a code; anything else
  /// maps by status.
  factory ThreadMemberException.fromDioException(DioException e) {
    final Object? data = e.response?.data;
    final String body = data is Map<String, dynamic>
        ? data.toString().toUpperCase()
        : '';
    if (body.contains('MAX_THREAD_MEMBERS') ||
        body.contains('THREAD_MEMBER_LIMIT')) {
      return const ThreadMemberException(ThreadMemberFailure.full);
    }
    return switch (e.response?.statusCode) {
      404 => const ThreadMemberException(ThreadMemberFailure.notFound),
      401 || 403 => const ThreadMemberException(ThreadMemberFailure.forbidden),
      _ => const ThreadMemberException(ThreadMemberFailure.unknown),
    };
  }

  @override
  String toString() => 'ThreadMemberException(${failure.name})';
}
