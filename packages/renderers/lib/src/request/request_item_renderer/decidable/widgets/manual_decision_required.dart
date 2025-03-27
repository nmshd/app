import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

class ManualDecisionRequired extends StatefulWidget {
  final bool isManualDecisionAccepted;
  final Function(bool) onUpdateManualDecision;

  const ManualDecisionRequired({super.key, required this.isManualDecisionAccepted, required this.onUpdateManualDecision});

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
          onTap: () => setState(() => widget.onUpdateManualDecision(widget.isManualDecisionAccepted)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Switch(
                thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                  (Set<WidgetState> states) => states.contains(WidgetState.selected) ? const Icon(Icons.check) : const Icon(Icons.close),
                ),
                activeColor: context.customColors.success,
                value: widget.isManualDecisionAccepted,
                onChanged: (bool value) => setState(() => widget.onUpdateManualDecision(value)),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TranslatedText('i18n://requestRenderer.manualDecisionRequiredDescription', style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
