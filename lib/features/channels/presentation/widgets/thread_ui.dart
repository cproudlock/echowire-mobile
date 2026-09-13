import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/permissions/channel_effective_permissions.dart';
import 'package:fluxer_app/core/permissions/permission.dart';
import 'package:fluxer_app/core/talker.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/data/thread_repository.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
import 'package:fluxer_app/features/ui/ui.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Echowire: shared, theme-aware building blocks for the thread list and the
// forum post list (moderation menu, tag chips, toasts).

enum ThreadModAction { togglePin, toggleArchive, toggleLock, delete }

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

/// The moderation actions [thread] offers the current user. Managers get every
/// action; a thread's owner may only close or reopen it.
List<ThreadModAction> threadModActionsFor({
  required Channel thread,
  required bool canManage,
  required String? currentUserId,
}) {
  if (canManage) {
    return ThreadModAction.values;
  }
  if (currentUserId != null && thread.ownerId == currentUserId) {
    return const <ThreadModAction>[ThreadModAction.toggleArchive];
  }
  return const <ThreadModAction>[];
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

/// A "more" button that opens the themed moderation menu for [thread].
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
      onPressed: () => unawaited(_openMenu(context, ref)),
    );
  }

  Future<void> _openMenu(BuildContext context, WidgetRef ref) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    final Offset position = box == null
        ? Offset.zero
        : box.localToGlobal(box.size.bottomRight(Offset.zero));
    final ThreadRepository repo = ref.read(threadRepositoryProvider);
    final Toast toast = ref.read(toastProvider.notifier);
    final String failedMessage = l10n.threadsActionFailed;
    final bool pinned = thread.threadPinned ?? false;

    Future<void> run(ThreadModAction action) async {
      try {
        switch (action) {
          case ThreadModAction.togglePin:
            await repo.updateThread(thread.id, pinned: !pinned);
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
          FluxerToast(
            message: failedMessage,
            variant: FluxerToastVariant.danger,
          ),
        );
      }
    }

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
              unawaited(run(action));
            },
          );
        }

        return <Widget>[
          for (final ThreadModAction action in actions)
            switch (action) {
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
}

/// A themed forum tag pill. Interactive when [onTap] is set.
class ForumTagChip extends StatelessWidget {
  const ForumTagChip({
    required this.label,
    this.selected = false,
    this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final layout = context.layout;
    final motion = context.motion;

    final Widget pill = AnimatedContainer(
      duration: motion.normal,
      curve: motion.curve,
      padding: EdgeInsets.symmetric(horizontal: layout.s2, vertical: layout.s1),
      decoration: BoxDecoration(
        color: selected ? colors.brandPrimary : colors.backgroundTertiary,
        borderRadius: layout.radiusFull,
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textStyles.label.copyWith(
          fontWeight: FontWeight.w600,
          color: selected ? colors.textOnBrandPrimary : colors.textSecondary,
        ),
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
