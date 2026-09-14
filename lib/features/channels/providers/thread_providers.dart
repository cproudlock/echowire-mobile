import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/api/fluxer_client_provider.dart';
import 'package:fluxer_app/core/providers/database_provider.dart';
import 'package:fluxer_app/core/talker.dart';
import 'package:fluxer_app/features/channels/data/thread_repository.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/domain/forum_view.dart';
import 'package:fluxer_dart/export.dart';
import 'package:riverpod/src/providers/stream_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'thread_providers.g.dart';

@Riverpod(keepAlive: true)
ThreadRepository threadRepository(Ref ref) {
  final FluxerClient client = ref.watch(fluxerClientProvider);
  final Dio dio = ref.watch(fluxerDioProvider);
  final db = ref.watch(fluxerDatabaseProvider);
  return ThreadRepository(client, dio, db);
}

/// Echowire: the current user's membership of a thread, or null while unknown.
/// Backed by [ThreadRepository.memberships], which joins, leaves, the member
/// list, the guild active threads endpoint and THREAD_MEMBERS_UPDATE all feed.
@riverpod
bool? threadMembership(Ref ref, String threadId) {
  final ThreadRepository repo = ref.watch(threadRepositoryProvider);
  void listener() => ref.invalidateSelf();
  repo.memberships.addListener(listener);
  ref.onDispose(() => repo.memberships.removeListener(listener));
  return repo.memberships.value[threadId];
}

/// Echowire: starter message previews for thread list rows, keyed by thread id.
@riverpod
Map<String, ThreadStarterPreview> threadStarterPreviews(Ref ref) {
  final ThreadRepository repo = ref.watch(threadRepositoryProvider);
  void listener() => ref.invalidateSelf();
  repo.starterPreviews.addListener(listener);
  ref.onDispose(() => repo.starterPreviews.removeListener(listener));
  return repo.starterPreviews.value;
}

/// Echowire: forum fields the SDK does not model, keyed by forum id.
@riverpod
ForumExtras? forumExtras(Ref ref, String forumId) {
  final ThreadRepository repo = ref.watch(threadRepositoryProvider);
  void listener() => ref.invalidateSelf();
  repo.forumExtras.addListener(listener);
  ref.onDispose(() => repo.forumExtras.removeListener(listener));
  return repo.forumExtras.value[forumId];
}

/// Echowire: the current user's known thread memberships, keyed by thread id.
@riverpod
Map<String, bool> threadMemberships(Ref ref) {
  final ThreadRepository repo = ref.watch(threadRepositoryProvider);
  void listener() => ref.invalidateSelf();
  repo.memberships.addListener(listener);
  ref.onDispose(() => repo.memberships.removeListener(listener));
  return repo.memberships.value;
}

/// Echowire: active threads across a guild (for nesting under channels in the
/// sidebar). Keyed by guild id. Refreshes from the guild active threads
/// endpoint, which also reports which threads the user has joined.
final StreamProviderFamily<List<Channel>, String> guildActiveThreadsProvider =
    StreamProvider.family<List<Channel>, String>((Ref ref, String guildId) {
      final ThreadRepository repo = ref.watch(threadRepositoryProvider);
      unawaited(
        repo.listGuildActiveThreads(guildId).catchError((
          Object e,
          StackTrace st,
        ) {
          talker.error('Could not load guild threads for $guildId', e, st);
          return null;
        }),
      );
      return repo.watchGuildThreads(guildId);
    });

/// Echowire: a channel's cached threads keyed by id, so messages can find the
/// thread started from them (a thread from a message reuses the message id).
final StreamProviderFamily<Map<String, Channel>, String>
parentThreadsByIdProvider = StreamProvider.family<Map<String, Channel>, String>(
  (Ref ref, String parentChannelId) {
    return ref
        .watch(threadRepositoryProvider)
        .watchThreads(parentChannelId)
        .map(
          (List<Channel> threads) => <String, Channel>{
            for (final Channel t in threads) t.id: t,
          },
        );
  },
);

/// Echowire: how many open posts in a forum have activity newer than the
/// user's last visit (the forum's read state), for the sidebar "N New" pill.
@riverpod
Stream<int> forumNewPostCount(Ref ref, String forumId) {
  final db = ref.watch(fluxerDatabaseProvider);
  final Stream<List<Channel>> posts = ref
      .watch(threadRepositoryProvider)
      .watchThreads(forumId);
  final StreamController<int> controller = StreamController<int>();
  List<Channel>? latestPosts;
  String? lastVisit;
  bool hasReadState = false;
  void emit() {
    final List<Channel>? current = latestPosts;
    if (current == null || !hasReadState) {
      return;
    }
    final String? visit = lastVisit;
    if (visit == null) {
      // Never visited: do not flag every post as new.
      controller.add(0);
      return;
    }
    controller.add(
      current
          .where(
            (Channel p) =>
                !p.isArchived &&
                compareSnowflakeStrings(p.activityId, visit) > 0,
          )
          .length,
    );
  }

  final List<StreamSubscription<Object?>> subs = <StreamSubscription<Object?>>[
    posts.listen((List<Channel> value) {
      latestPosts = value;
      emit();
    }),
    db.readStateDao.watchReadState(forumId).listen((rs) {
      hasReadState = true;
      lastVisit = rs?.lastMessageId;
      emit();
    }),
  ];
  ref.onDispose(() {
    for (final StreamSubscription<Object?> sub in subs) {
      unawaited(sub.cancel());
    }
    unawaited(controller.close());
  });
  return controller.stream.distinct();
}
