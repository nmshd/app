import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '/src/attribute/identity_attribute_value_renderer.dart';
import '/src/attribute/relationship_attribute_value_renderer.dart';
import '/src/checkbox_settings.dart';
import 'empty_attribute.dart';
import 'manual_decision_required.dart';

class ProcessedIdentityAttributeQueryRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
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
      return EmptyAttribute(
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
            ManualDecisionRequired(checkboxSettings: checkboxSettings!),
          ],
        ]),
      ),
    );
  }
}

class ProcessedRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedRelationshipAttributeQueryDVO query;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
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
      return EmptyAttribute(
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
          ManualDecisionRequired(checkboxSettings: checkboxSettings!),
        ],
      ],
    );
  }
}

class ProcessedThirdPartyRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedThirdPartyRelationshipAttributeQueryDVO query;
  final CheckboxSettings? checkboxSettings;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
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
      return EmptyAttribute(
        valueType: query.valueType!,
        checkboxSettings: checkboxSettings,
        mustBeAccepted: mustBeAccepted,
        onCreateAttribute: () async {
          onUpdateAttribute!(query.valueType!);
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
                            onPressed: () => onUpdateAttribute!(query.valueType!),
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
          ManualDecisionRequired(checkboxSettings: checkboxSettings!),
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
  final Future<void> Function(String valueType)? onUpdateAttribute;
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
      return EmptyAttribute(
        titleOverride: (title) => '${requestItemTitle ?? title}${mustBeAccepted ? '*' : ''}',
        valueType: query.valueType!,
        checkboxSettings: checkboxSettings,
        mustBeAccepted: mustBeAccepted,
        onCreateAttribute: () async {
          onUpdateAttribute!(query.valueType!);
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
                          onPressed: () => onUpdateAttribute!(query.valueType!),
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
          ManualDecisionRequired(checkboxSettings: checkboxSettings!),
        ],
      ],
    );
  }
}
