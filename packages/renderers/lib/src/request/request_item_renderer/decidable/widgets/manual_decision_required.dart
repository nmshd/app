import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:renderers/src/checkbox_settings.dart';

class ManualDecisionRequired extends StatefulWidget {
  final CheckboxSettings checkboxSettings;

  const ManualDecisionRequired({
    super.key,
    required this.checkboxSettings,
  });

  @override
  State<ManualDecisionRequired> createState() => _ManualDecisionRequiredState();
}

class _ManualDecisionRequiredState extends State<ManualDecisionRequired> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: InkWell(
          onTap: () {
            setState(() => widget.checkboxSettings.onUpdateManualDecision!(!widget.checkboxSettings.isManualDecided));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Switch(
                thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                  (Set<WidgetState> states) => states.contains(WidgetState.selected) ? const Icon(Icons.check) : const Icon(Icons.close),
                ),
                activeColor: context.customColors.success,
                value: widget.checkboxSettings.isManualDecided,
                onChanged: (bool value) {
                  setState(() {
                    widget.checkboxSettings.onUpdateManualDecision!(value);
                  });
                },
              ),
              SizedBox(width: 8),
              Expanded(
                child: TranslatedText(
                  'i18n://requestRenderer.manualDecisionRequiredDescription',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
