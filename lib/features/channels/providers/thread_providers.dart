import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/api/fluxer_client_provider.dart';
import 'package:fluxer_app/core/providers/database_provider.dart';
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

/// Echowire: active threads across a guild (for nesting under channels in the
/// sidebar). Keyed by guild id.
final StreamProviderFamily<List<Channel>, String> guildActiveThreadsProvider =
    StreamProvider.family<List<Channel>, String>((Ref ref, String guildId) {
      return ref.watch(threadRepositoryProvider).watchGuildThreads(guildId);
    });
