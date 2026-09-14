import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/talker.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/domain/forum_view.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
import 'package:fluxer_app/features/chat/domain/message.dart';
import 'package:fluxer_app/features/chat/providers/core/chat_providers.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:fluxer_app/shared/providers/member_role_color.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'thread_starter_card.g.dart';

/// Echowire: the starter message of a thread. Uses the list preview when one
/// is cached, otherwise fetches the parent message with the thread's id
/// (threads started from a message reuse its id). Resolves to null for threads
/// not started from a message.
@riverpod
Future<ThreadStarterPreview?> threadStarter(
  Ref ref,
  String parentId,
  String threadId,
) async {
  final ThreadStarterPreview? cached = ref.read(
    threadStarterPreviewsProvider,
  )[threadId];
  if (cached != null) {
    return cached;
  }
  try {
    final Message message = await ref
        .read(messageRepositoryProvider)
        .fetchMessage(channelId: parentId, messageId: threadId);
    return ThreadStarterPreview(
      messageId: message.id,
      content: message.content,
      authorId: message.authorId,
      authorName: message.authorName,
    );
  } on Exception catch (e) {
    talker.debug('No starter message for thread $threadId: $e');
    return null;
  }
}

/// Echowire: shows a thread's starter message at the top of the thread.
class ThreadStarterCard extends ConsumerWidget {
  const ThreadStarterCard({required this.thread, super.key});

  final Channel thread;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? parentId = thread.parentId;
    if (parentId == null) {
      return const SizedBox.shrink();
    }
    final ThreadStarterPreview? starter = ref
        .watch(threadStarterProvider(parentId, thread.id))
        .value;
    if (starter == null || starter.content.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    final colors = context.colors;
    final layout = context.layout;
    final String? authorId = starter.authorId;
    final Color? authorColor = authorId == null
        ? null
        : ref.watch(memberRoleColorProvider((authorId, thread.guildId)));
    return Container(
      margin: EdgeInsets.only(top: layout.s3),
      padding: EdgeInsets.all(layout.s3),
      decoration: BoxDecoration(
        color: colors.backgroundSecondary,
        borderRadius: layout.radiusMd,
        border: Border(left: BorderSide(color: colors.borderColor, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            FluxerLocalizations.of(context).threadsStarterMessage,
            style: context.textStyles.label.copyWith(
              color: colors.textTertiaryMuted,
            ),
          ),
          SizedBox(height: layout.s1),
          if (starter.authorName != null)
            Text(
              starter.authorName!,
              style: context.textStyles.bodySmall.copyWith(
                color: authorColor ?? colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          Text(
            starter.content.trim(),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: context.textStyles.bodyMedium.copyWith(
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
