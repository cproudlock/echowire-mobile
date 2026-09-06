import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluxer_app/core/api/fluxer_client_provider.dart';
import 'package:fluxer_app/core/providers/database_provider.dart';
import 'package:fluxer_app/features/channels/data/thread_repository.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_dart/export.dart';
import 'package:riverpod/src/providers/stream_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'thread_providers.g.dart';

@Riverpod(keepAlive: true)
ThreadRepository threadRepository(Ref ref) {
  final FluxerClient client = ref.watch(fluxerClientProvider);
  final db = ref.watch(fluxerDatabaseProvider);
  return ThreadRepository(client, db);
}

/// Echowire: optimistic local membership for a thread (null = unknown until the
/// user joins/leaves in this session). Keyed by thread channel id.
final StateProviderFamily<bool?, String> threadMembershipProvider =
    StateProvider.family<bool?, String>((Ref ref, String threadId) => null);

/// Echowire: active threads across a guild (for nesting under channels in the
/// sidebar). Keyed by guild id.
final StreamProviderFamily<List<Channel>, String> guildActiveThreadsProvider =
    StreamProvider.family<List<Channel>, String>((Ref ref, String guildId) {
      return ref.watch(threadRepositoryProvider).watchGuildThreads(guildId);
    });
