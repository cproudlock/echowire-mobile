import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/talker.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/presentation/widgets/thread_ui.dart';
import 'package:fluxer_app/features/channels/providers/channel_providers.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
import 'package:fluxer_app/features/chat/presentation/widgets/messages/message_reactions_bar.dart';
import 'package:fluxer_app/features/chat/providers/core/chat_providers.dart';
import 'package:fluxer_app/features/chat/providers/core/chat_view_model.dart';
import 'package:fluxer_app/features/chat/utils/messages/message_link.dart';
import 'package:fluxer_app/features/ui/ui.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:fluxer_app/shared/utils/clipboard_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Echowire: the head of an open forum post, mirroring the web and desktop
// clients: the post icon, its title, the applied tags, then a row of post
// actions. The date divider and the starter message come from the message list
// itself, because a forum post's starter IS its first message.

/// Header shown at the top of an open forum post.
class ForumPostHeader extends ConsumerWidget {
  const ForumPostHeader({required this.post, required this.forum, super.key});

  /// The forum post (a thread whose parent is a forum channel).
  final Channel post;

  /// The forum the post lives in.
  final Channel forum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final layout = context.layout;
    final List<String> tagNames = <String>[
      for (final String id in post.appliedTags ?? const <String>[])
        for (final ForumTag tag in forum.availableTags ?? const <ForumTag>[])
          if (tag.id == id) tag.name,
    ];
    return Padding(
      padding: EdgeInsets.fromLTRB(layout.s4, layout.s6, layout.s4, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.guildListForeground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              PhosphorIconsFill.chatCircle,
              size: 36,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: layout.s3),
          Text(
            post.name,
            style: context.textStyles.heading.copyWith(fontSize: 24),
          ),
          if (tagNames.isNotEmpty) ...<Widget>[
            SizedBox(height: layout.s2),
            Wrap(
              spacing: layout.s1,
              runSpacing: layout.s1,
              children: <Widget>[
                for (final String name in tagNames) ForumTagChip(label: name),
              ],
            ),
          ],
          SizedBox(height: layout.s3),
          _PostActionRow(post: post, forum: forum),
        ],
      ),
    );
  }
}

/// React to the post, follow it, or copy its link.
class _PostActionRow extends ConsumerWidget {
  const _PostActionRow({required this.post, required this.forum});

  final Channel post;
  final Channel forum;

  /// The forum's default reaction emoji, when it sets one.
  String? get _defaultReaction {
    final String? raw = forum.defaultReactionEmojiJson;
    if (raw == null || raw.isEmpty) {
      return null;
    }
    final Object? decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      return null;
    }
    final String? name = decoded['emoji_name'] as String?;
    return (name == null || name.isEmpty) ? null : name;
  }

  /// The starter message id, known once the post list or the post view has
  /// cached its preview. Null on servers that send no preview.
  String? _starterMessageId(WidgetRef ref) =>
      ref.watch(threadStarterPreviewsProvider)[post.id]?.messageId;

  Future<void> _react(
    BuildContext context,
    WidgetRef ref,
    String messageId, {
    required bool useDefault,
  }) async {
    final String? fallback = _defaultReaction;
    if (useDefault && fallback != null) {
      await _applyReaction(ref, messageId, fallback);
      return;
    }
    await openReactionPickerSheet(
      context,
      channelId: post.id,
      onEmojiSelected: (FluxerSelectedEmoji emoji) {
        dispatchSelectedEmojiReaction(emoji, (
          String value, {
          String? emojiId,
          bool animated = false,
        }) {
          unawaited(
            _applyReaction(
              ref,
              messageId,
              value,
              emojiId: emojiId,
              animated: animated,
            ),
          );
        });
      },
    );
  }

  /// Reacts through the chat view model when the starter is loaded, so the
  /// count updates at once, and falls back to the API when it is not.
  Future<void> _applyReaction(
    WidgetRef ref,
    String messageId,
    String emoji, {
    String? emojiId,
    bool animated = false,
  }) async {
    try {
      final bool loaded = ref
          .read(chatViewModelProvider)
          .messages
          .any((message) => message.id == messageId);
      if (loaded) {
        await ref
            .read(chatViewModelProvider.notifier)
            .toggleReaction(
              messageId,
              emoji,
              emojiId: emojiId,
              animated: animated,
            );
        return;
      }
      await ref
          .read(messageRepositoryProvider)
          .addReaction(
            channelId: post.id,
            messageId: messageId,
            emoji: emojiId == null ? emoji : ':$emoji:$emojiId',
          );
    } on Exception catch (e, st) {
      talker.error('Could not react to post ${post.id}', e, st);
      if (ref.context.mounted) {
        showThreadToast(
          ref,
          FluxerLocalizations.of(ref.context).threadsActionFailed,
        );
      }
    }
  }

  Future<void> _toggleFollow(WidgetRef ref, {required bool isMember}) async {
    final FluxerLocalizations l10n = FluxerLocalizations.of(ref.context);
    try {
      final repo = ref.read(threadRepositoryProvider);
      if (isMember) {
        await repo.leaveThread(post.id);
      } else {
        await repo.joinThread(post.id);
      }
    } on Exception catch (e, st) {
      talker.error('Could not change following for ${post.id}', e, st);
      showThreadToast(ref, l10n.threadsActionFailed);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final layout = context.layout;
    final bool isMember = ref.watch(threadMembershipProvider(post.id)) ?? false;
    final String? messageId = _starterMessageId(ref);
    final String? defaultReaction = _defaultReaction;
    return Wrap(
      spacing: layout.s2,
      runSpacing: layout.s2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        if (messageId != null)
          FluxerButton.secondary(
            icon: defaultReaction == null ? PhosphorIconsBold.smiley : null,
            label: defaultReaction == null
                ? l10n.forumReactToPost
                : '$defaultReaction  ${l10n.forumReactToPost}',
            size: FluxerButtonSize.compact,
            fitContent: true,
            onPressed: () =>
                unawaited(_react(context, ref, messageId, useDefault: true)),
          ),
        if (messageId != null && defaultReaction != null)
          FluxerButton.ghost(
            icon: PhosphorIconsBold.smiley,
            isSquare: true,
            size: FluxerButtonSize.compact,
            semanticLabel: l10n.forumReactToPostOther,
            onPressed: () =>
                unawaited(_react(context, ref, messageId, useDefault: false)),
          ),
        FluxerButton.ghost(
          icon: isMember ? PhosphorIconsFill.bell : PhosphorIconsBold.bell,
          label: isMember ? l10n.threadsFollowing : l10n.threadsFollow,
          size: FluxerButtonSize.compact,
          fitContent: true,
          onPressed: () => unawaited(_toggleFollow(ref, isMember: isMember)),
        ),
        FluxerButton.ghost(
          icon: PhosphorIconsBold.link,
          isSquare: true,
          size: FluxerButtonSize.compact,
          semanticLabel: l10n.channelDetailsCopyLink,
          onPressed: () => unawaited(
            copyToClipboard(
              context: context,
              value: channelLink(post.id, post.guildId),
            ),
          ),
        ),
      ],
    );
  }
}

/// The forum a post belongs to, or null when the parent is not a forum.
Channel? forumParentOf(WidgetRef ref, Channel channel) {
  final String? parentId = channel.parentId;
  if (!channel.isThread || parentId == null) {
    return null;
  }
  final Channel? parent = ref.watch(channelByIdProvider(parentId)).value;
  return (parent?.isForum ?? false) ? parent : null;
}
