import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

class ManualDecisionRequired extends StatelessWidget {
  final bool isManualDecisionAccepted;
  final Function(bool)? onUpdateManualDecision;
  final String i18nKey;

  const ManualDecisionRequired({super.key, required this.isManualDecisionAccepted, required this.onUpdateManualDecision, required this.i18nKey});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(4),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: InkWell(
        onTap: onUpdateManualDecision != null ? () => onUpdateManualDecision!(!isManualDecisionAccepted) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Switch(
                thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
                  return states.contains(WidgetState.selected) ? const Icon(Icons.check) : const Icon(Icons.close);
                }),
                activeColor: context.customColors.onSuccess,
                activeTrackColor:
                    onUpdateManualDecision == null ? context.customColors.success.withValues(alpha: 0.16) : context.customColors.success,
                inactiveTrackColor: Colors.transparent,
                value: isManualDecisionAccepted,
                onChanged: onUpdateManualDecision,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TranslatedText(i18nKey, style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
