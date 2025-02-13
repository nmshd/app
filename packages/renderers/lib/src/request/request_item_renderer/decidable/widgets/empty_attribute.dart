import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:renderers/src/checkbox_settings.dart';

import 'manual_decision_required.dart';

class EmptyAttribute extends StatelessWidget {
  final String valueType;
  final VoidCallback onCreateAttribute;
  final CheckboxSettings? checkboxSettings;
  final bool mustBeAccepted;
  final bool? requireManualDecision;
  final String Function(String)? titleOverride;

  const EmptyAttribute({
    super.key,
    required this.valueType,
    required this.onCreateAttribute,
    required this.mustBeAccepted,
    this.requireManualDecision,
    this.checkboxSettings,
    this.titleOverride,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCreateAttribute,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                // TODO: long press on checkbox is absorbed by the InkWell below
                if (checkboxSettings != null) Checkbox(value: checkboxSettings!.isChecked, onChanged: checkboxSettings!.onUpdateCheckbox),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(right: 24),
                    visualDensity: VisualDensity.compact,
                    tileColor: Theme.of(context).colorScheme.surface,
                    title: Text(
                      titleOverride != null
                          ? titleOverride!(FlutterI18n.translate(context, 'dvo.attribute.name.$valueType'))
                          : '${FlutterI18n.translate(context, 'dvo.attribute.name.$valueType')}${mustBeAccepted ? '*' : ''}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    subtitle: TranslatedText(
                      'i18n://requestRenderer.noEntry',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outline),
                    ),
                    trailing: Icon(Icons.add, color: Theme.of(context).colorScheme.primary, size: 24),
                  ),
                ),
              ],
            ),
            if (requireManualDecision == true) ...[SizedBox(height: 12), ManualDecisionRequired(checkboxSettings: checkboxSettings!)],
          ],
        ),
      ),
    );
  }
}
