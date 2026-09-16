import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/permissions/channel_effective_permissions.dart';
import 'package:fluxer_app/core/permissions/permission.dart';
import 'package:fluxer_app/core/talker.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/data/thread_repository.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/presentation/sheets/channel_notification_settings_sheet.dart';
import 'package:fluxer_app/features/channels/presentation/sheets/mute_duration_sheet.dart';
import 'package:fluxer_app/features/channels/providers/channel_mute_provider.dart';
import 'package:fluxer_app/features/channels/providers/channel_providers.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
import 'package:fluxer_app/features/chat/utils/messages/message_link.dart';
import 'package:fluxer_app/features/guilds/data/guild_user_settings_repository.dart';
import 'package:fluxer_app/features/ui/ui.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:fluxer_app/shared/utils/clipboard_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Echowire: shared, theme-aware building blocks for the thread list and the
// forum post list (moderation menu, tag chips, toasts).

enum ThreadModAction {
  follow,
  editPost,
  copyLink,
  mute,
  notificationSettings,
  togglePin,
  toggleArchive,
  toggleLock,
  delete,
}

/// Whether the current user may moderate threads under [parentChannelId].
bool watchCanManageThreads(WidgetRef ref, String parentChannelId) {
  final int bits =
      ref
          .watch(effectiveGuildChannelPermissionBitsProvider(parentChannelId))
          .value ??
      0;
  return hasPermission(bits, Permission.manageChannels);
}

/// Non-reactive variant of [watchCanManageThreads] for use outside `build`.
bool readCanManageThreads(WidgetRef ref, String parentChannelId) {
  final int bits =
      ref
          .read(effectiveGuildChannelPermissionBitsProvider(parentChannelId))
          .value ??
      0;
  return hasPermission(bits, Permission.manageChannels);
}

/// The actions [thread] offers the current user, following the server rules:
/// anyone can follow, mute, set notifications and copy the link; the owner or
/// a moderator can edit and delete; the owner can close or reopen their own
/// unlocked thread; pin and lock are moderator only.
List<ThreadModAction> threadModActionsFor({
  required Channel thread,
  required bool canManage,
  required String? currentUserId,
}) {
  final bool isOwner = currentUserId != null && thread.ownerId == currentUserId;
  return <ThreadModAction>[
    ThreadModAction.follow,
    ThreadModAction.mute,
    ThreadModAction.notificationSettings,
    ThreadModAction.copyLink,
    if (canManage || isOwner) ThreadModAction.editPost,
    if (canManage) ThreadModAction.togglePin,
    if (canManage || (isOwner && !thread.isLocked))
      ThreadModAction.toggleArchive,
    if (canManage) ThreadModAction.toggleLock,
    if (canManage || isOwner) ThreadModAction.delete,
  ];
}

void showThreadToast(
  WidgetRef ref,
  String message, {
  FluxerToastVariant variant = FluxerToastVariant.danger,
}) {
  ref
      .read(toastProvider.notifier)
      .show(FluxerToast(message: message, variant: variant));
}

/// A "more" button that opens the themed thread menu for [thread].
class ThreadModMenuButton extends ConsumerWidget {
  const ThreadModMenuButton({
    required this.thread,
    required this.actions,
    super.key,
  });

  final Channel thread;
  final List<ThreadModAction> actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    return FluxerButton.ghost(
      icon: PhosphorIconsBold.dotsThreeVertical,
      isSquare: true,
      size: FluxerButtonSize.compact,
      semanticLabel: l10n.threadsManage,
      onPressed: () {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        final Offset position = box == null
            ? Offset.zero
            : box.localToGlobal(box.size.bottomRight(Offset.zero));
        unawaited(
          showThreadActionsMenu(
            context,
            ref,
            thread: thread,
            actions: actions,
            position: position,
          ),
        );
      },
    );
  }
}

/// Opens the themed thread or forum post menu for [thread] at [position].
Future<void> showThreadActionsMenu(
  BuildContext context,
  WidgetRef ref, {
  required Channel thread,
  required List<ThreadModAction> actions,
  Offset position = Offset.zero,
}) {
  final FluxerLocalizations l10n = FluxerLocalizations.of(context);
  final bool pinned = thread.threadPinned ?? false;
  final bool isMember = ref.read(threadMembershipProvider(thread.id)) ?? false;
  final bool isMuted =
      (ref.read(mutedChannelIdsProvider(thread.guildId)).value ??
              const <String>{})
          .contains(thread.id);

  return FluxerActionMenu.show(
    context,
    position: position,
    builder: (BuildContext menuContext, VoidCallback close) {
      Widget item(
        ThreadModAction action,
        String label,
        PhosphorIconData icon, {
        bool isDanger = false,
      }) {
        return FluxerMenuItem(
          label: label,
          icon: icon,
          isDanger: isDanger,
          onPressed: () {
            close();
            unawaited(
              runThreadAction(
                context,
                ref,
                thread: thread,
                action: action,
                isMember: isMember,
                isMuted: isMuted,
              ),
            );
          },
        );
      }

      return <Widget>[
        for (final ThreadModAction action in actions)
          switch (action) {
            ThreadModAction.follow => item(
              action,
              isMember ? l10n.threadsUnfollow : l10n.threadsFollow,
              isMember ? PhosphorIconsBold.bellSlash : PhosphorIconsBold.bell,
            ),
            ThreadModAction.mute => item(
              action,
              isMuted ? l10n.threadsUnmute : l10n.threadsMute,
              isMuted
                  ? PhosphorIconsBold.speakerHigh
                  : PhosphorIconsBold.speakerSlash,
            ),
            ThreadModAction.notificationSettings => item(
              action,
              l10n.notificationSettings,
              PhosphorIconsBold.bellRinging,
            ),
            ThreadModAction.copyLink => item(
              action,
              l10n.channelDetailsCopyLink,
              PhosphorIconsBold.link,
            ),
            ThreadModAction.editPost => item(
              action,
              l10n.threadsEditThread,
              PhosphorIconsBold.pencilSimple,
            ),
            ThreadModAction.togglePin => item(
              action,
              pinned ? l10n.threadsUnpin : l10n.threadsPin,
              PhosphorIconsBold.pushPin,
            ),
            ThreadModAction.toggleArchive => item(
              action,
              thread.isArchived ? l10n.threadsUnarchive : l10n.threadsArchive,
              PhosphorIconsBold.archive,
            ),
            ThreadModAction.toggleLock => item(
              action,
              thread.isLocked ? l10n.threadsUnlock : l10n.threadsLock,
              thread.isLocked
                  ? PhosphorIconsBold.lockOpen
                  : PhosphorIconsBold.lock,
            ),
            ThreadModAction.delete => item(
              action,
              l10n.threadsDelete,
              PhosphorIconsBold.trash,
              isDanger: true,
            ),
          },
      ];
    },
  );
}

/// Runs one thread menu [action], reporting failures as a toast.
Future<void> runThreadAction(
  BuildContext context,
  WidgetRef ref, {
  required Channel thread,
  required ThreadModAction action,
  required bool isMember,
  required bool isMuted,
}) async {
  final FluxerLocalizations l10n = FluxerLocalizations.of(context);
  final ThreadRepository repo = ref.read(threadRepositoryProvider);
  final Toast toast = ref.read(toastProvider.notifier);
  final String failedMessage = l10n.threadsActionFailed;
  try {
    switch (action) {
      case ThreadModAction.follow:
        if (isMember) {
          await repo.leaveThread(thread.id);
        } else {
          await repo.joinThread(thread.id);
        }
      case ThreadModAction.mute:
        final GuildUserSettingsRepository settings = ref.read(
          guildUserSettingsRepositoryProvider,
        );
        if (isMuted) {
          await settings.updateChannelOverride(
            guildId: thread.guildId,
            channelId: thread.id,
            muted: false,
          );
        } else {
          final MuteSelection? selection = await showMuteDurationSheet(
            context,
            muteTitle: l10n.threadsMute,
          );
          if (selection == null) {
            return;
          }
          await settings.updateChannelOverride(
            guildId: thread.guildId,
            channelId: thread.id,
            muted: true,
            durationSeconds: selection.durationSeconds,
          );
        }
      case ThreadModAction.notificationSettings:
        if (context.mounted) {
          await showChannelNotificationSettingsSheet(context, channel: thread);
        }
      case ThreadModAction.copyLink:
        if (context.mounted) {
          await copyToClipboard(
            context: context,
            value: channelLink(thread.id, thread.guildId),
          );
        }
      case ThreadModAction.editPost:
        if (context.mounted) {
          await showEditThreadModal(context, ref, thread: thread);
        }
      case ThreadModAction.togglePin:
        await repo.updateThread(
          thread.id,
          pinned: !(thread.threadPinned ?? false),
        );
      case ThreadModAction.toggleArchive:
        await repo.updateThread(thread.id, archived: !thread.isArchived);
      case ThreadModAction.toggleLock:
        await repo.updateThread(thread.id, locked: !thread.isLocked);
      case ThreadModAction.delete:
        await repo.deleteThread(thread.id);
    }
  } on Exception catch (e, st) {
    talker.error('Thread action $action failed for ${thread.id}', e, st);
    toast.show(
      FluxerToast(message: failedMessage, variant: FluxerToastVariant.danger),
    );
  }
}

/// Edit a thread's or forum post's title, and a post's tags.
Future<void> showEditThreadModal(
  BuildContext context,
  WidgetRef ref, {
  required Channel thread,
}) async {
  final FluxerLocalizations l10n = FluxerLocalizations.of(context);
  final String? parentId = thread.parentId;
  final Channel? parent = parentId == null
      ? null
      : ref.read(channelByIdProvider(parentId)).value;
  final bool isPost = parent?.isForum ?? false;
  final List<ForumTag> availableTags = isPost
      ? (parent!.availableTags ?? const <ForumTag>[])
      : const <ForumTag>[];
  final Set<String> moderatedTagIds = isPost
      ? (ref.read(forumExtrasProvider(parent!.id))?.moderatedTagIds ??
            const <String>{})
      : const <String>{};
  final bool canManageTags =
      parentId != null && readCanManageThreads(ref, parentId);
  final TextEditingController title = TextEditingController(text: thread.name);
  final ValueNotifier<Set<String>> tags = ValueNotifier<Set<String>>(<String>{
    ...?thread.appliedTags,
  });
  final bool? save = await FluxerModal.show<bool>(
    context,
    title: isPost ? l10n.forumEditPost : l10n.threadsEditThread,
    builder: (BuildContext modalContext, VoidCallback close) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FluxerInput(
          controller: title,
          label: l10n.forumPostTitleLabel,
          maxLength: 100,
          autofocus: true,
        ),
        if (availableTags.isNotEmpty) ...<Widget>[
          SizedBox(height: modalContext.layout.s4),
          Text(
            (parent?.forumRequireTag ?? false)
                ? l10n.forumPostTagsRequiredLabel
                : l10n.forumPostTagsLabel,
            style: modalContext.textStyles.label.copyWith(
              color: modalContext.colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: modalContext.layout.s2),
          ValueListenableBuilder<Set<String>>(
            valueListenable: tags,
            builder: (BuildContext _, Set<String> selected, Widget? _) => Wrap(
              spacing: modalContext.layout.s2,
              runSpacing: modalContext.layout.s2,
              children: <Widget>[
                for (final ForumTag tag in availableTags)
                  ForumTagChip(
                    label: tag.name,
                    selected: selected.contains(tag.id),
                    moderated: moderatedTagIds.contains(tag.id),
                    onTap: (!canManageTags && moderatedTagIds.contains(tag.id))
                        ? null
                        : () => tags.value = selected.contains(tag.id)
                              ? (<String>{...selected}..remove(tag.id))
                              : <String>{...selected, tag.id},
                  ),
              ],
            ),
          ),
        ],
      ],
    ),
    actionsBuilder: (pop) => <Widget>[
      FluxerButton.primary(onPressed: () => pop(true), label: l10n.save),
      const SizedBox(height: 8),
      FluxerButton.secondary(onPressed: pop, label: l10n.cancel),
    ],
  );
  final String name = title.text.trim();
  final Set<String> selectedTags = tags.value;
  if (save != true || name.isEmpty) {
    return;
  }
  final bool requireTag = parent?.forumRequireTag ?? false;
  if (requireTag && availableTags.isNotEmpty && selectedTags.isEmpty) {
    showThreadToast(ref, l10n.forumPostTagRequiredToast);
    return;
  }
  try {
    await ref
        .read(threadRepositoryProvider)
        .updateThread(
          thread.id,
          name: name == thread.name ? null : name,
          appliedTags: availableTags.isEmpty ? null : selectedTags.toList(),
        );
  } on Exception catch (e, st) {
    talker.error('Could not edit thread ${thread.id}', e, st);
    showThreadToast(ref, l10n.threadsActionFailed);
  }
}

/// A themed forum tag pill. Interactive when [onTap] is set.
class ForumTagChip extends StatelessWidget {
  const ForumTagChip({
    required this.label,
    this.selected = false,
    this.moderated = false,
    this.onTap,
    super.key,
  });

  final String label;
  final bool selected;

  /// Marks a tag only moderators may apply.
  final bool moderated;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final layout = context.layout;
    final motion = context.motion;

    final Color contentColor = selected
        ? colors.textOnBrandPrimary
        : colors.textSecondary;
    final Widget pill = AnimatedContainer(
      duration: motion.normal,
      curve: motion.curve,
      padding: EdgeInsets.symmetric(horizontal: layout.s2, vertical: layout.s1),
      decoration: BoxDecoration(
        color: selected ? colors.brandPrimary : colors.backgroundTertiary,
        borderRadius: layout.radiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (moderated) ...<Widget>[
            Icon(PhosphorIconsFill.shieldCheck, size: 11, color: contentColor),
            SizedBox(width: layout.s1 / 2),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyles.label.copyWith(
                fontWeight: FontWeight.w600,
                color: contentColor,
              ),
            ),
          ),
        ],
      ),
    );
    final VoidCallback? handler = onTap;
    if (handler == null) {
      return pill;
    }
    return FluxerTappable(
      onTap: handler,
      selected: selected,
      semanticLabel: label,
      excludeChildSemantics: true,
      builder: (BuildContext _, Set<WidgetState> _) => pill,
    );
  }
}

/// Centered, muted status text for empty and error states in thread lists.
class ThreadListMessage extends StatelessWidget {
  const ThreadListMessage({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.layout.s8),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: context.textStyles.bodySmall.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
