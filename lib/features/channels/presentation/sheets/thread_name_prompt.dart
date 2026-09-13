import 'package:fluxer_app/features/ui/ui.dart';
import 'package:fluxer_app/l10n/generated/fluxer_localizations.dart';
import 'package:fluxer_app/material_ui.dart';

/// Echowire: themed prompt for a new thread's name. Resolves to the trimmed
/// name, or null when dismissed.
Future<String?> showThreadNamePrompt(BuildContext context) {
  final FluxerLocalizations l10n = FluxerLocalizations.of(context);
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<bool> isValid = ValueNotifier<bool>(false);

  return FluxerModal.show<String>(
    context,
    title: l10n.threadsNewThreadTitle,
    builder: (BuildContext dialogContext, VoidCallback close) => FluxerInput(
      controller: controller,
      label: l10n.threadsNameLabel,
      hint: l10n.threadsNameHint,
      maxLength: 100,
      autofocus: true,
      textInputAction: TextInputAction.done,
      onChanged: (String value) => isValid.value = value.trim().isNotEmpty,
      onSubmitted: (String value) {
        if (value.trim().isNotEmpty) {
          Navigator.of(dialogContext).pop(value.trim());
        }
      },
    ),
    actionsBuilder: (pop) => <Widget>[
      ValueListenableBuilder<bool>(
        valueListenable: isValid,
        builder: (BuildContext _, bool valid, Widget? _) =>
            FluxerButton.primary(
              onPressed: valid ? () => pop(controller.text.trim()) : null,
              label: l10n.threadsCreateThread,
            ),
      ),
      const SizedBox(height: 8),
      FluxerButton.secondary(onPressed: pop, label: l10n.cancel),
    ],
  );
}
