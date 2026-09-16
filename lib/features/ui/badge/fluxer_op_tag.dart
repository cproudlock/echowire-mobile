import 'package:fluxer_app/core/theme/fluxer_theme_extension.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';

// Echowire: marks the author who started a thread or forum post, the way
// Discord badges the original poster.
class FluxerOpTag extends StatelessWidget {
  const FluxerOpTag({super.key});

  @override
  Widget build(BuildContext context) {
    final FluxerLocalizations l10n = FluxerLocalizations.of(context);
    final colors = context.colors;
    return Container(
      constraints: const BoxConstraints(minHeight: 15),
      padding: const EdgeInsets.symmetric(horizontal: 5.5, vertical: 2),
      decoration: BoxDecoration(
        color: colors.backgroundTertiary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        l10n.threadsOriginalPosterTag,
        style: context.textStyles.smallText.copyWith(
          color: colors.textSecondary,
          fontSize: 10,
          height: 1,
        ),
      ),
    );
  }
}
