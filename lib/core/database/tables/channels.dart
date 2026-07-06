import 'package:drift/drift.dart';

@TableIndex(name: 'idx_channels_guild', columns: {#guildId})
class Channels extends Table {
  TextColumn get id => text()();
  TextColumn get guildId => text()();
  TextColumn get name => text()();
  TextColumn get url => text().nullable()();
  IntColumn get type => integer().withDefault(const Constant(0))();
  TextColumn get topic => text().nullable()();
  TextColumn get parentId => text().nullable()();
  IntColumn get position => integer().withDefault(const Constant(0))();
  TextColumn get lastMessageId => text().nullable()();
  TextColumn get lastPinTimestamp => text().nullable()();
  IntColumn get rateLimitPerUser => integer().withDefault(const Constant(0))();
  BoolColumn get nsfw => boolean().withDefault(const Constant(false))();
  BoolColumn get nsfwOverride => boolean().nullable()();
  IntColumn get contentWarningLevel =>
      integer().withDefault(const Constant(0))();
  TextColumn get contentWarningText => text().nullable()();
  TextColumn get permissionOverwritesJson => text().nullable()();
  IntColumn get userLimit => integer().nullable()();

  // Echowire: threads + forum channels. A thread is a channel with a thread type
  // (11/12) and a parent_id; a forum (15) carries tag config. All nullable —
  // populated only on thread/forum channels.
  TextColumn get ownerId => text().nullable()();
  // thread_metadata.* (flattened to columns, matching the server's storage)
  BoolColumn get threadArchived => boolean().nullable()();
  IntColumn get threadAutoArchiveDuration => integer().nullable()();
  TextColumn get threadArchiveTimestamp => text().nullable()();
  BoolColumn get threadLocked => boolean().nullable()();
  BoolColumn get threadInvitable => boolean().nullable()();
  TextColumn get threadCreateTimestamp => text().nullable()();
  IntColumn get threadMemberCount => integer().nullable()();
  IntColumn get threadMessageCount => integer().nullable()();
  BoolColumn get threadPinned => boolean().nullable()();
  // forum-post applied tag IDs (JSON array of strings)
  TextColumn get appliedTagsJson => text().nullable()();
  // forum-channel config
  TextColumn get availableTagsJson => text().nullable()();
  IntColumn get defaultSortOrder => integer().nullable()();
  IntColumn get forumDefaultAutoArchiveDuration => integer().nullable()();
  BoolColumn get forumRequireTag => boolean().nullable()();
  TextColumn get defaultReactionEmojiJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
