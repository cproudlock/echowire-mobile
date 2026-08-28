import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:fluxer_app/core/database/fluxer_database.dart' as db;

/// Echowire: a selectable tag on a forum channel (and applied to forum posts).
class ForumTag {
  final String id;
  final String name;
  final String? emojiName;

  const ForumTag({required this.id, required this.name, this.emojiName});

  factory ForumTag.fromJson(Map<String, dynamic> json) => ForumTag(
    id: json['id'] as String,
    name: json['name'] as String? ?? '',
    emojiName: json['emoji_name'] as String?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'emoji_name': emojiName,
  };
}

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

@immutable
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
  final int? bitrate;
  final String? rtcRegion;
  final int? voiceConnectionLimit;

  // Echowire: thread + forum fields (populated only on thread/forum channels).
  final String? ownerId;
  final bool? threadArchived;
  final int? threadAutoArchiveDuration;
  final String? threadArchiveTimestamp;
  final bool? threadLocked;
  final bool? threadInvitable;
  final String? threadCreateTimestamp;
  final int? threadMemberCount;
  final int? threadMessageCount;
  final bool? threadPinned;
  final List<String>? appliedTags;
  final List<ForumTag>? availableTags;
  final int? defaultSortOrder;
  final int? forumDefaultAutoArchiveDuration;
  final bool? forumRequireTag;
  final String? defaultReactionEmojiJson;

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
    this.ownerId,
    this.threadArchived,
    this.threadAutoArchiveDuration,
    this.threadArchiveTimestamp,
    this.threadLocked,
    this.threadInvitable,
    this.threadCreateTimestamp,
    this.threadMemberCount,
    this.threadMessageCount,
    this.threadPinned,
    this.appliedTags,
    this.availableTags,
    this.defaultSortOrder,
    this.forumDefaultAutoArchiveDuration,
    this.forumRequireTag,
    this.defaultReactionEmojiJson,
    this.bitrate,
    this.rtcRegion,
    this.voiceConnectionLimit,
  });

  Channel copyWith({
    String? id,
    String? guildId,
    String? name,
    String? url,
    ChannelType? type,
    String? topic,
    String? parentId,
    int? position,
    int? rateLimitPerUser,
    bool? nsfw,
    bool? nsfwOverride,
    int? contentWarningLevel,
    String? contentWarningText,
    String? permissionOverwritesJson,
    int? userLimit,
    int? bitrate,
    String? rtcRegion,
    int? voiceConnectionLimit,
  }) {
    return Channel(
      id: id ?? this.id,
      guildId: guildId ?? this.guildId,
      name: name ?? this.name,
      url: url ?? this.url,
      type: type ?? this.type,
      topic: topic ?? this.topic,
      parentId: parentId ?? this.parentId,
      position: position ?? this.position,
      rateLimitPerUser: rateLimitPerUser ?? this.rateLimitPerUser,
      nsfw: nsfw ?? this.nsfw,
      nsfwOverride: nsfwOverride ?? this.nsfwOverride,
      contentWarningLevel: contentWarningLevel ?? this.contentWarningLevel,
      contentWarningText: contentWarningText ?? this.contentWarningText,
      permissionOverwritesJson:
          permissionOverwritesJson ?? this.permissionOverwritesJson,
      userLimit: userLimit ?? this.userLimit,
      bitrate: bitrate ?? this.bitrate,
      rtcRegion: rtcRegion ?? this.rtcRegion,
      voiceConnectionLimit: voiceConnectionLimit ?? this.voiceConnectionLimit,
    );
  }

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
      ownerId: row.ownerId,
      threadArchived: row.threadArchived,
      threadAutoArchiveDuration: row.threadAutoArchiveDuration,
      threadArchiveTimestamp: row.threadArchiveTimestamp,
      threadLocked: row.threadLocked,
      threadInvitable: row.threadInvitable,
      threadCreateTimestamp: row.threadCreateTimestamp,
      threadMemberCount: row.threadMemberCount,
      threadMessageCount: row.threadMessageCount,
      threadPinned: row.threadPinned,
      appliedTags: _decodeStringList(row.appliedTagsJson),
      availableTags: _decodeForumTags(row.availableTagsJson),
      defaultSortOrder: row.defaultSortOrder,
      forumDefaultAutoArchiveDuration: row.forumDefaultAutoArchiveDuration,
      forumRequireTag: row.forumRequireTag,
      defaultReactionEmojiJson: row.defaultReactionEmojiJson,
      bitrate: row.bitrate,
      rtcRegion: row.rtcRegion,
      voiceConnectionLimit: row.voiceConnectionLimit,
    );
  }

  static List<String>? _decodeStringList(String? json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    final Object? decoded = jsonDecode(json);
    if (decoded is! List) {
      return null;
    }
    return decoded.map((Object? e) => e.toString()).toList();
  }

  static List<ForumTag>? _decodeForumTags(String? json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    final Object? decoded = jsonDecode(json);
    if (decoded is! List) {
      return null;
    }
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(ForumTag.fromJson)
        .toList();
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
      ownerId: Value(ownerId),
      threadArchived: Value(threadArchived),
      threadAutoArchiveDuration: Value(threadAutoArchiveDuration),
      threadArchiveTimestamp: Value(threadArchiveTimestamp),
      threadLocked: Value(threadLocked),
      threadInvitable: Value(threadInvitable),
      threadCreateTimestamp: Value(threadCreateTimestamp),
      threadMemberCount: Value(threadMemberCount),
      threadMessageCount: Value(threadMessageCount),
      threadPinned: Value(threadPinned),
      appliedTagsJson: Value(
        appliedTags == null ? null : jsonEncode(appliedTags),
      ),
      availableTagsJson: Value(
        availableTags == null
            ? null
            : jsonEncode(
                availableTags!.map((ForumTag t) => t.toJson()).toList(),
              ),
      ),
      defaultSortOrder: Value(defaultSortOrder),
      forumDefaultAutoArchiveDuration: Value(forumDefaultAutoArchiveDuration),
      forumRequireTag: Value(forumRequireTag),
      defaultReactionEmojiJson: Value(defaultReactionEmojiJson),
      bitrate: Value(bitrate),
      rtcRegion: Value(rtcRegion),
      voiceConnectionLimit: Value(voiceConnectionLimit),
    );
  }

  bool get isCategory => type == ChannelType.guildCategory;

  /// Echowire: this channel is a thread (public or private).
  bool get isThread => threadChannelTypes.contains(type);

  /// Echowire: this channel is a forum container.
  bool get isForum => type == ChannelType.guildForum;

  /// Echowire: an archived thread (composer should be disabled).
  bool get isArchived => threadArchived ?? false;

  /// Echowire: a locked thread (only moderators can send).
  bool get isLocked => threadLocked ?? false;
  @override
  bool operator ==(Object other) {
    return other is Channel &&
        other.id == id &&
        other.guildId == guildId &&
        other.name == name &&
        other.url == url &&
        other.type == type &&
        other.topic == topic &&
        other.parentId == parentId &&
        other.position == position &&
        other.rateLimitPerUser == rateLimitPerUser &&
        other.nsfw == nsfw &&
        other.nsfwOverride == nsfwOverride &&
        other.contentWarningLevel == contentWarningLevel &&
        other.contentWarningText == contentWarningText &&
        other.permissionOverwritesJson == permissionOverwritesJson &&
        other.userLimit == userLimit &&
        other.bitrate == bitrate &&
        other.rtcRegion == rtcRegion &&
        other.voiceConnectionLimit == voiceConnectionLimit;
  }

  @override
  int get hashCode => Object.hash(
    id,
    guildId,
    name,
    url,
    type,
    topic,
    parentId,
    position,
    rateLimitPerUser,
    nsfw,
    nsfwOverride,
    contentWarningLevel,
    contentWarningText,
    permissionOverwritesJson,
    userLimit,
    bitrate,
    rtcRegion,
    voiceConnectionLimit,
  );
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
