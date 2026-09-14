import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/router/route_names.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/data/read_state_utils.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/providers/thread_providers.dart';
import 'package:fluxer_app/features/ui/tappable/fluxer_tappable.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';
import 'package:fluxer_app/shared/utils/relative_time.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Echowire: the thread started from a message, shown under it like Discord:
/// the thread name, its message count and last activity. A thread created from
/// a message reuses that message's id, so the lookup is by message id among
/// the channel's cached threads. Renders nothing when there is no thread.
class MessageThreadLink extends ConsumerWidget {
  const MessageThreadLink({
    required this.messageId,
    required this.channelId,
    super.key,
  });

  final String messageId;
  final String channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Channel? thread = ref.watch(
      parentThreadsByIdProvider(
        channelId,
      ).select((AsyncValue<Map<String, Channel>> a) => a.value?[messageId]),
    );
    if (thread == null) {
      return const SizedBox.shrink();
    }
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final colors = context.colors;
    final layout = context.layout;
    final TextStyle meta = context.textStyles.label.copyWith(
      color: colors.textTertiaryMuted,
    );
    final int activityMs = snowflakeTimestampMs(thread.activityId);
    final int count = thread.threadMessageCount ?? 0;
    return Padding(
      padding: EdgeInsets.only(top: layout.s1),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FluxerTappable(
          onTap: () =>
              context.go(RoutePaths.guildChannel(thread.guildId, thread.id)),
          semanticLabel: thread.name,
          builder: (BuildContext _, Set<WidgetState> _) => Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: EdgeInsets.symmetric(
              horizontal: layout.s3,
              vertical: layout.s2,
            ),
            decoration: BoxDecoration(
              color: colors.backgroundSecondary,
              borderRadius: layout.radiusMd,
              border: Border.all(color: colors.borderColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  PhosphorIconsBold.chatText,
                  size: 16,
                  color: colors.textSecondary,
                ),
                SizedBox(width: layout.s2),
                Flexible(
                  child: Text(
                    thread.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyles.bodySmall.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: layout.s2),
                Text(l10n.threadsMessageCount(count), style: meta),
                if (activityMs > 0) ...<Widget>[
                  Text('  ·  ', style: meta),
                  Text(
                    relativeTime(
                      DateTime.fromMillisecondsSinceEpoch(activityMs),
                      l10n,
                    ),
                    style: meta,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
