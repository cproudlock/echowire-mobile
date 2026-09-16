import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/features/channels/domain/channel.dart';
import 'package:fluxer_app/features/channels/presentation/widgets/channel_icon.dart';
import 'package:fluxer_app/features/chat/presentation/widgets/messages/forum_post_header.dart';
import 'package:fluxer_app/features/chat/presentation/widgets/messages/thread_starter_card.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';

/// Start-of-channel welcome for guild text/voice channels, mirroring the web
/// client's `ChannelWelcomeSection`. Shown at the top of fully-loaded history
/// and as the empty state.
class ChannelWelcomeSection extends ConsumerWidget {
  const ChannelWelcomeSection({
    required this.channel,
    this.effectivePermissionBits,
    super.key,
  });

  final Channel channel;
  final int? effectivePermissionBits;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    // Echowire: a forum post opens with its title, tags and post actions; its
    // starter message is the first message the list below renders.
    final Channel? forum = forumParentOf(ref, channel);
    if (forum != null) {
      return ForumPostHeader(post: channel, forum: forum);
    }
    final String displayName = '#${channel.name}';
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.guildListForeground,
              shape: BoxShape.circle,
            ),
            child: ChannelIcon(
              type: channel.type,
              channel: channel,
              effectivePermissionBits: effectivePermissionBits,
              size: 48,
              color: context.colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.channelWelcomeHeading(displayName),
            style: context.textStyles.heading.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.channelWelcomeDescription(displayName),
            style: context.textStyles.bodyMedium.copyWith(
              color: context.colors.textPrimaryMuted,
            ),
          ),
          // Echowire: a thread opens with the message it was started from.
          if (channel.isThread) ThreadStarterCard(thread: channel),
        ],
      ),
    );
  }
}
