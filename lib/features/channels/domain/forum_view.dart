import 'package:flutter/foundation.dart';

// Echowire: forum and thread view models that the server contract adds on top
// of the generated SDK (docs/forums-contract.md on the server branch). They are
// parsed from raw JSON and kept in memory, so older servers that omit the
// fields simply leave them null.

/// Forum post ordering. Wire values match `default_sort_order`.
enum ForumSortOrder {
  latestActivity(0),
  creationDate(1);

  const ForumSortOrder(this.wireValue);

  final int wireValue;

  static ForumSortOrder fromWire(int? value) =>
      value == 1 ? ForumSortOrder.creationDate : ForumSortOrder.latestActivity;
}

/// Forum post layout. Wire values match `default_forum_layout` (0 = unset,
/// treated as list).
enum ForumLayout {
  list(1),
  gallery(2);

  const ForumLayout(this.wireValue);

  final int wireValue;

  static ForumLayout fromWire(int? value) =>
      value == 2 ? ForumLayout.gallery : ForumLayout.list;
}

/// The starter message summary the server attaches to thread list responses.
@immutable
class ThreadStarterPreview {
  const ThreadStarterPreview({
    required this.messageId,
    required this.content,
    this.authorId,
    this.authorName,
    this.authorAvatar,
    this.attachmentUrl,
    this.attachmentIsImage = false,
  });

  final String messageId;
  final String content;
  final String? authorId;
  final String? authorName;
  final String? authorAvatar;
  final String? attachmentUrl;
  final bool attachmentIsImage;

  static ThreadStarterPreview? fromJson(Object? json) {
    if (json is! Map<String, dynamic>) {
      return null;
    }
    final Object? messageId = json['message_id'];
    if (messageId is! String) {
      return null;
    }
    final Object? author = json['author'];
    final Map<String, dynamic>? authorMap = author is Map<String, dynamic>
        ? author
        : null;
    final Object? attachment = json['first_attachment'];
    final Map<String, dynamic>? attachmentMap =
        attachment is Map<String, dynamic> ? attachment : null;
    final String? contentType = attachmentMap?['content_type'] as String?;
    final String? url =
        (attachmentMap?['proxy_url'] as String?) ??
        (attachmentMap?['url'] as String?);
    return ThreadStarterPreview(
      messageId: messageId,
      content: json['content'] as String? ?? '',
      authorId: authorMap?['id'] as String?,
      authorName:
          (authorMap?['global_name'] as String?) ??
          (authorMap?['username'] as String?),
      authorAvatar: authorMap?['avatar'] as String?,
      attachmentUrl: url,
      attachmentIsImage:
          url != null && (contentType?.startsWith('image/') ?? false),
    );
  }
}

/// Forum fields the generated SDK does not model yet.
@immutable
class ForumExtras {
  const ForumExtras({
    this.defaultLayout,
    this.defaultThreadRateLimitPerUser,
    this.moderatedTagIds = const <String>{},
  });

  final int? defaultLayout;
  final int? defaultThreadRateLimitPerUser;

  /// Tags only moderators may apply. Empty on servers that do not send
  /// `moderated`, so every tag stays selectable there.
  final Set<String> moderatedTagIds;

  factory ForumExtras.fromChannelJson(Map<String, dynamic> json) => ForumExtras(
    defaultLayout: (json['default_forum_layout'] as num?)?.toInt(),
    defaultThreadRateLimitPerUser:
        (json['default_thread_rate_limit_per_user'] as num?)?.toInt(),
    moderatedTagIds: moderatedTagIdsFromChannelJson(json),
  );
}

/// The ids of the forum's moderator-only tags, read from the raw channel JSON.
/// The generated SDK drops `moderated`, so it is parsed here and held in
/// memory beside the other forum extras.
Set<String> moderatedTagIdsFromChannelJson(Map<String, dynamic> json) {
  final Object? tags = json['available_tags'];
  if (tags is! List) {
    return const <String>{};
  }
  return <String>{
    for (final Object? tag in tags)
      if (tag is Map<String, dynamic> &&
          tag['moderated'] == true &&
          tag['id'] is String)
        tag['id'] as String,
  };
}

/// The recent distinct authors of a forum post, most recent first, for the
/// avatar row on a post card. A rolling window of up to five, not a membership
/// list. Absent on servers before the forums phase 2 contract.
@immutable
class ThreadParticipants {
  const ThreadParticipants(this.userIds);

  final List<String> userIds;

  static ThreadParticipants? fromThreadJson(Map<String, dynamic> json) {
    final Object? ids = json['recent_participant_ids'];
    if (ids is! List) {
      return null;
    }
    final List<String> userIds = <String>[
      for (final Object? id in ids)
        if (id is String) id,
    ];
    return userIds.isEmpty ? null : ThreadParticipants(userIds);
  }
}
