import 'package:drift/drift.dart';
import 'package:fluxer_app/core/database/fluxer_database.dart' as db;

enum ChannelType {
  guildText(0),
  dm(1),
  guildVoice(2),
  groupDm(3),
  guildCategory(4),
  // Echowire: threads + forum channels (absent upstream). A thread IS a channel
  // with a thread type and a parent_id; a forum is a container of thread posts.
  publicThread(11),
  privateThread(12),
  guildForum(15),
  guildLink(998),
  dmPersonalNotes(999);

  const ChannelType(this.wireValue);

  final int wireValue;

  static ChannelType fromWire(int value) {
    for (final ChannelType type in values) {
      if (type.wireValue == value) {
        return type;
      }
    }
    return ChannelType.guildText;
  }
}

/// Echowire: channel types that are threads (public + private).
const Set<ChannelType> threadChannelTypes = <ChannelType>{
  ChannelType.publicThread,
  ChannelType.privateThread,
};

bool isThreadChannelType(int type) =>
    type == ChannelType.publicThread.wireValue ||
    type == ChannelType.privateThread.wireValue;

bool isForumChannelType(int type) => type == ChannelType.guildForum.wireValue;

/// Guild channels that support text based unread tracking (text + voice + threads).
const Set<ChannelType> guildTextBasedChannelTypes = <ChannelType>{
  ChannelType.guildText,
  ChannelType.guildVoice,
  ChannelType.publicThread,
  ChannelType.privateThread,
};

bool isGuildTextBasedChannel(int type) =>
    type == ChannelType.guildText.wireValue ||
    type == ChannelType.guildVoice.wireValue ||
    isThreadChannelType(type);

bool isGuildTextBasedChannelType(ChannelType type) =>
    guildTextBasedChannelTypes.contains(type);

bool isGuildVoiceChannelType(int type) =>
    type == ChannelType.guildVoice.wireValue;

bool isGuildCategoryChannelType(int type) =>
    type == ChannelType.guildCategory.wireValue;

bool isGuildLinkChannelType(int type) =>
    type == ChannelType.guildLink.wireValue;

class Channel {
  final String id;
  final String guildId;
  final String name;
  final String? url;
  final ChannelType type;
  final String? topic;
  final String? parentId;
  final int position;
  final int rateLimitPerUser;
  final bool nsfw;
  final bool? nsfwOverride;
  final int contentWarningLevel;
  final String? contentWarningText;
  final String? permissionOverwritesJson;
  final int? userLimit;

  const Channel({
    required this.id,
    required this.guildId,
    required this.name,
    this.url,
    this.type = ChannelType.guildText,
    this.topic,
    this.parentId,
    this.position = 0,
    this.rateLimitPerUser = 0,
    this.nsfw = false,
    this.nsfwOverride,
    this.contentWarningLevel = 0,
    this.contentWarningText,
    this.permissionOverwritesJson,
    this.userLimit,
  });

  factory Channel.fromRow(db.Channel row) {
    return Channel(
      id: row.id,
      guildId: row.guildId,
      name: row.name,
      url: row.url,
      type: ChannelType.fromWire(row.type),
      topic: row.topic,
      parentId: row.parentId,
      position: row.position,
      rateLimitPerUser: row.rateLimitPerUser,
      nsfw: row.nsfw,
      nsfwOverride: row.nsfwOverride,
      contentWarningLevel: row.contentWarningLevel,
      contentWarningText: row.contentWarningText,
      permissionOverwritesJson: row.permissionOverwritesJson,
      userLimit: row.userLimit,
    );
  }

  db.ChannelsCompanion toCompanion() {
    return db.ChannelsCompanion.insert(
      id: id,
      guildId: guildId,
      name: name,
      url: Value(url),
      type: Value(type.wireValue),
      topic: Value(topic),
      parentId: Value(parentId),
      position: Value(position),
      rateLimitPerUser: Value(rateLimitPerUser),
      nsfw: Value(nsfw),
      nsfwOverride: Value(nsfwOverride),
      contentWarningLevel: Value(contentWarningLevel),
      contentWarningText: Value(contentWarningText),
      permissionOverwritesJson: Value(permissionOverwritesJson),
      userLimit: Value(userLimit),
    );
  }

  bool get isCategory => type == ChannelType.guildCategory;
}

class ChannelCategory {
  final String id;
  final String name;
  final List<Channel> channels;

  const ChannelCategory({
    required this.id,
    required this.name,
    required this.channels,
  });

  bool get isUncategorized => id == kUncategorizedCategoryId;
}

/// Internal group id for channels that have no parent category.
const String kUncategorizedCategoryId = '_uncategorized';

/// Groups a flat list of channels into channel categories.
///
/// Channels with type 4 (category) become group headers. Child channels
/// reference their category via parentId. Channels without a parent
/// are placed in an internal uncategorized group.
List<ChannelCategory> groupChannelsIntoCategories(List<Channel> channels) {
  final categories = <Channel>[];
  final uncategorized = <Channel>[];
  final parentMap = <String, List<Channel>>{};

  for (final ch in channels) {
    if (ch.isCategory) {
      categories.add(ch);
    } else if (ch.parentId != null) {
      parentMap.putIfAbsent(ch.parentId!, () => <Channel>[]).add(ch);
    } else {
      uncategorized.add(ch);
    }
  }

  uncategorized.sort(_compareChannelForDisplay);
  categories.sort(_compareChannelOrdering);

  final result = <ChannelCategory>[];

  if (uncategorized.isNotEmpty) {
    result.add(
      ChannelCategory(
        id: kUncategorizedCategoryId,
        name: 'Channels',
        channels: uncategorized,
      ),
    );
  }

  for (final cat in categories) {
    final children = (parentMap[cat.id] ?? <Channel>[])
      ..sort(_compareChannelForDisplay);
    result.add(ChannelCategory(id: cat.id, name: cat.name, channels: children));
  }

  return result;
}

int _compareChannelOrdering(Channel a, Channel b) {
  final positionComparison = a.position.compareTo(b.position);
  return positionComparison != 0 ? positionComparison : a.id.compareTo(b.id);
}

int _compareChannelForDisplay(Channel a, Channel b) {
  final aBucket = _channelDisplayBucket(a);
  final bBucket = _channelDisplayBucket(b);
  final bucketComparison = aBucket.compareTo(bBucket);
  return bucketComparison != 0
      ? bucketComparison
      : _compareChannelOrdering(a, b);
}

int _channelDisplayBucket(Channel channel) {
  switch (channel.type) {
    case ChannelType.guildVoice:
      return 1;
    case ChannelType.guildText:
    case ChannelType.guildLink:
    case ChannelType.guildCategory:
    case ChannelType.guildForum:
    case ChannelType.publicThread:
    case ChannelType.privateThread:
    case ChannelType.dm:
    case ChannelType.groupDm:
    case ChannelType.dmPersonalNotes:
      return 0;
  }
}
