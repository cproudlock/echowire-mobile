import 'package:fluxer_app/core/api/fluxer_client_provider.dart';
import 'package:fluxer_app/core/providers/database_provider.dart';
import 'package:fluxer_app/features/channels/data/channel_repository.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'channel_providers.g.dart';

typedef ChannelPermissionIdentity = ({
  String guildId,
  int type,
  String? parentId,
  String? permissionOverwritesJson,
});

@Riverpod(keepAlive: true)
ChannelRepository channelRepository(Ref ref) {
  final client = ref.watch(fluxerClientProvider);
  final dio = ref.watch(fluxerDioProvider);
  final db = ref.watch(fluxerDatabaseProvider);
  return ChannelRepository(client, dio, db);
}

@riverpod
Stream<Channel?> channelById(Ref ref, String id) {
  final db = ref.watch(fluxerDatabaseProvider);
  return db.channelDao
      .watchChannelById(id)
      .map((row) => row == null ? null : Channel.fromRow(row))
      // Echowire: a lastMessageId-only write must not re-emit. The tail
      // pointer moves on every message, and this provider is watched from
      // composer permissions and from per-message widgets, so including it
      // rebuilt those on every message in the channel.
      .distinct(
        (Channel? previous, Channel? next) => previous == null || next == null
            ? previous == next
            : previous.sameExceptLastMessage(next),
      );
}

/// Echowire: resolve a channel the local database does not hold, by asking the
/// server for it once. A routed id that is missing locally is usually an
/// archived thread, because a session payload carries open channels and open
/// threads only. Null means gone or not visible, so a caller can fall back to
/// whatever it did before.
@riverpod
Future<Channel?> recoveredChannel(Ref ref, String id) async {
  if (id.isEmpty) {
    return null;
  }
  final db = ref.watch(fluxerDatabaseProvider);
  final existing = await db.channelDao.getChannelById(id);
  if (existing != null) {
    return Channel.fromRow(existing);
  }
  return ref.watch(channelRepositoryProvider).fetchChannelById(id);
}

@riverpod
Stream<String?> channelGuildId(Ref ref, String id) {
  if (id.isEmpty) {
    return Stream<String?>.value(null);
  }
  final db = ref.watch(fluxerDatabaseProvider);
  return db.channelDao
      .watchChannelById(id)
      .map((row) => row?.guildId)
      .distinct();
}

@riverpod
Stream<ChannelPermissionIdentity?> channelPermissionIdentity(
  Ref ref,
  String id,
) {
  if (id.isEmpty) {
    return Stream<ChannelPermissionIdentity?>.value(null);
  }
  final db = ref.watch(fluxerDatabaseProvider);
  return db.channelDao.watchChannelById(id).map((row) {
    if (row == null) {
      return null;
    }
    return (
      guildId: row.guildId,
      type: row.type,
      parentId: row.parentId,
      permissionOverwritesJson: row.permissionOverwritesJson,
    );
  }).distinct();
}

@riverpod
Stream<List<Channel>> allChannels(Ref ref) {
  final db = ref.watch(fluxerDatabaseProvider);
  return db.channelDao.watchAllChannels().map(
    (rows) => rows.map(Channel.fromRow).toList(),
  );
}
