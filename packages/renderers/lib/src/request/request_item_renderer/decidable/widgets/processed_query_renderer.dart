import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '/src/attribute/identity_attribute_value_renderer.dart';
import '/src/attribute/relationship_attribute_value_renderer.dart';
import '/src/checkbox_settings.dart';

class ProcessedIdentityAttributeQueryRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function([String? valueType, String? value])? onUpdateAttribute;
  final CheckboxSettings? checkboxSettings;
  final bool mustBeAccepted;
  final bool? requireManualDecision;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

  const ProcessedIdentityAttributeQueryRenderer({
    super.key,
    required this.query,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.checkboxSettings,
    required this.mustBeAccepted,
    required this.requireManualDecision,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (query.results.isEmpty && selectedAttribute == null) {
      return _EmptyAttribute(
        valueType: query.valueType,
        checkboxSettings: checkboxSettings,
        mustBeAccepted: mustBeAccepted,
        requireManualDecision: requireManualDecision,
        onCreateAttribute: () async {
          onUpdateAttribute!(query.valueType);
        },
      );
    }

    return InkWell(
      onTap: () => onUpdateAttribute!(query.valueType),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(children: [
          Row(
            children: [
              if (checkboxSettings != null)
                IgnorePointer(child: Checkbox(value: checkboxSettings!.isChecked, onChanged: checkboxSettings!.onUpdateCheckbox)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: IdentityAttributeValueRenderer(
                    titleOverride: (title) => '$title${mustBeAccepted ? '*' : ''}',
                    value: selectedAttribute != null
                        ? (selectedAttribute as IdentityAttribute).value
                        : query.results.first.value as IdentityAttributeValue,
                    valueHints: query.valueHints,
                    trailing: onUpdateAttribute == null
                        ? null
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (query.results.length > 1)
                                Flexible(
                                  child: Text('+${query.results.length - 1}'),
                                ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.chevron_right,
                              )
                            ],
                          ),
                    expandFileReference: expandFileReference,
                    openFileDetails: openFileDetails,
                  ),
                ),
              ),
            ],
          ),
          if (requireManualDecision == true) ...[
            SizedBox(height: 12),
            _ManualDecisionRequired(checkboxSettings: checkboxSettings!),
          ],
        ]),
      ),
    );
  }
}

class _ManualDecisionRequired extends StatefulWidget {
  final CheckboxSettings checkboxSettings;

  const _ManualDecisionRequired({
    required this.checkboxSettings,
  });

  @override
  State<_ManualDecisionRequired> createState() => _ManualDecisionRequiredState();
}

class _ManualDecisionRequiredState extends State<_ManualDecisionRequired> {
  // bool manualDecision = false;

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
                activeColor: Colors.green, // TODO: use color scheme
                value: widget.checkboxSettings.isManualDecided,
                onChanged: (bool value) {
                  setState(() {
                    // widget.checkboxSettings.isManualDecided = value;
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

class _EmptyAttribute extends StatelessWidget {
  final String valueType;
  final VoidCallback onCreateAttribute;
  final CheckboxSettings? checkboxSettings;
  final bool mustBeAccepted;
  final bool? requireManualDecision;

  const _EmptyAttribute({
    required this.valueType,
    required this.onCreateAttribute,
    required this.mustBeAccepted,
    this.requireManualDecision,
    this.checkboxSettings,
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
                      '${FlutterI18n.translate(context, 'dvo.attribute.name.$valueType')}${mustBeAccepted ? '*' : ''}',
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
            if (requireManualDecision == true) ...[
              SizedBox(height: 12),
              _ManualDecisionRequired(checkboxSettings: checkboxSettings!),
            ],
          ],
        ),
      ),
    );
  }
}

class ProcessedRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedRelationshipAttributeQueryDVO query;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function([String? valueType, String? value])? onUpdateAttribute;
  final CheckboxSettings? checkboxSettings;
  final bool mustBeAccepted;
  final bool? requireManualDecision;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

  const ProcessedRelationshipAttributeQueryRenderer({
    super.key,
    required this.query,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.checkboxSettings,
    this.requireManualDecision,
    required this.mustBeAccepted,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    final selectedAttribute = this.selectedAttribute;

    if (query.results.isEmpty) {
      return _EmptyAttribute(
        valueType: query.valueType,
        checkboxSettings: checkboxSettings,
        mustBeAccepted: mustBeAccepted,
        onCreateAttribute: () async {
          onUpdateAttribute!(query.valueType);
        },
      );
    }

    return Column(
      children: [
        Row(
          children: [
            if (checkboxSettings != null) Checkbox(value: checkboxSettings!.isChecked, onChanged: checkboxSettings!.onUpdateCheckbox),
            Expanded(
              child: RelationshipAttributeValueRenderer(
                value: selectedAttribute is RelationshipAttribute ? selectedAttribute.value : query.results.first.value as RelationshipAttributeValue,
                trailing: onUpdateAttribute == null
                    ? null
                    : SizedBox(
                        width: 50,
                        child: IconButton(
                          onPressed: () => onUpdateAttribute!(query.valueType),
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ),
                expandFileReference: expandFileReference,
                openFileDetails: openFileDetails,
              ),
            ),
          ],
        ),
        if (requireManualDecision == true) ...[
          SizedBox(height: 12),
          _ManualDecisionRequired(checkboxSettings: checkboxSettings!),
        ],
      ],
    );
  }
}

class ProcessedThirdPartyRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedThirdPartyRelationshipAttributeQueryDVO query;
  final CheckboxSettings? checkboxSettings;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function()? onUpdateAttribute;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;
  final bool mustBeAccepted;
  final bool? requireManualDecision;

  const ProcessedThirdPartyRelationshipAttributeQueryRenderer({
    super.key,
    required this.query,
    this.checkboxSettings,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.requireManualDecision,
    required this.expandFileReference,
    required this.openFileDetails,
    required this.mustBeAccepted,
  });

  @override
  Widget build(BuildContext context) {
    final selectedAttribute = this.selectedAttribute;

    if (query.results.isEmpty) {
      return _EmptyAttribute(
        valueType: query.valueType!,
        checkboxSettings: checkboxSettings,
        mustBeAccepted: mustBeAccepted,
        onCreateAttribute: () async {
          onUpdateAttribute!();
        },
      );
    }

    return Column(
      children: [
        Row(
          children: [
            if (checkboxSettings != null)
              Checkbox(value: checkboxSettings!.isChecked, onChanged: query.results.isEmpty ? null : checkboxSettings!.onUpdateCheckbox),
            if (selectedAttribute != null || query.results.isNotEmpty)
              Expanded(
                child: RelationshipAttributeValueRenderer(
                  value:
                      selectedAttribute is RelationshipAttribute ? selectedAttribute.value : query.results.first.value as RelationshipAttributeValue,
                  trailing: onUpdateAttribute == null
                      ? null
                      : SizedBox(
                          width: 50,
                          child: IconButton(
                            onPressed: () => onUpdateAttribute!(),
                            icon: const Icon(Icons.chevron_right),
                          ),
                        ),
                  expandFileReference: expandFileReference,
                  openFileDetails: openFileDetails,
                ),
              )
            else
              TranslatedText(
                'i18n://dvo.attributeQuery.ThirdPartyRelationshipAttributeQuery.noResults',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
        if (requireManualDecision == true) ...[
          SizedBox(height: 12),
          _ManualDecisionRequired(checkboxSettings: checkboxSettings!),
        ],
      ],
    );
  }
}

class ProcessedIQLQueryRenderer extends StatelessWidget {
  final String? requestItemTitle;
  final ProcessedIQLQueryDVO query;
  final CheckboxSettings? checkboxSettings;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function([String? valueType, String? value])? onUpdateAttribute;
  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final bool mustBeAccepted;
  final bool? requireManualDecision;
  final void Function(FileDVO) openFileDetails;

  const ProcessedIQLQueryRenderer({
    super.key,
    required this.requestItemTitle,
    required this.query,
    this.checkboxSettings,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.requireManualDecision,
    required this.expandFileReference,
    required this.chooseFile,
    required this.mustBeAccepted,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    final selectedAttribute = this.selectedAttribute;

    if (query.results.isEmpty && selectedAttribute == null) {
      // TODO: title override missing
      return _EmptyAttribute(
        valueType: query.valueType!,
        checkboxSettings: checkboxSettings,
        mustBeAccepted: mustBeAccepted,
        onCreateAttribute: () async {
          onUpdateAttribute!(query.valueType);
        },
      );
    }

    return Column(
      children: [
        Row(
          children: [
            if (checkboxSettings != null) Checkbox(value: checkboxSettings!.isChecked, onChanged: checkboxSettings!.onUpdateCheckbox),
            Expanded(
              child: IdentityAttributeValueRenderer(
                titleOverride: (title) => '${requestItemTitle ?? title}${mustBeAccepted ? '*' : ''}',
                value: selectedAttribute is IdentityAttribute ? selectedAttribute.value : query.results.first.value as IdentityAttributeValue,
                valueHints: query.results.firstOrNull?.valueHints ?? query.valueHints!,
                trailing: onUpdateAttribute == null
                    ? null
                    : SizedBox(
                        width: 50,
                        child: IconButton(
                          onPressed: () => onUpdateAttribute!(query.valueType),
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ),
                expandFileReference: expandFileReference,
                openFileDetails: openFileDetails,
              ),
            ),
          ],
        ),
        if (requireManualDecision == true) ...[
          SizedBox(height: 12),
          _ManualDecisionRequired(checkboxSettings: checkboxSettings!),
        ],
      ],
    );
  }
}
