import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluxer_app/core/api/fluxer_client_provider.dart';
import 'package:fluxer_app/core/providers/database_provider.dart';
import 'package:fluxer_app/features/channels/data/thread_repository.dart';
import 'package:fluxer_dart/export.dart';
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
final threadMembershipProvider = StateProvider.family<bool?, String>(
  (Ref ref, String threadId) => null,
);
