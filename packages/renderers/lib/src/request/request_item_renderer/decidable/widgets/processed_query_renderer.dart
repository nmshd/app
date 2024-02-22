import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';
import 'package:value_renderer/value_renderer.dart';

import '../../../request_renderer_controller.dart';
import '../../widgets/value_renderer_list_tile.dart';
import '/src/attribute/identity_attribute_value_renderer.dart';
import '/src/attribute/relationship_attribute_value_renderer.dart';
import '/src/checkbox_settings.dart';

class ProcessedIdentityAttributeQueryRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final RequestRendererController? controller;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
  final CheckboxSettings? checkboxSettings;
  final void Function({String? valueType, ValueRendererInputValue? inputValue, required bool isComplex}) onUpdateInput;
  final bool mustBeAccepted;

  const ProcessedIdentityAttributeQueryRenderer({
    super.key,
    required this.query,
    this.controller,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.checkboxSettings,
    required this.onUpdateInput,
    required this.mustBeAccepted,
  });

  @override
  Widget build(BuildContext context) {
    final selectedAttribute = this.selectedAttribute;

    if (query.results.isEmpty) {
      return ValueRendererListTile(
        fieldName: switch (query.valueType) {
          'Affiliation' ||
          'BirthDate' ||
          'BirthPlace' ||
          'DeliveryBoxAddress' ||
          'PersonName' ||
          'PostOfficeBoxAddress' ||
          'StreetAddress' =>
            'i18n://attributes.values.${query.valueType}._title',
          _ => 'i18n://dvo.attribute.name.${query.valueType}',
        },
        renderHints: query.renderHints,
        valueHints: query.valueHints,
        onUpdateInput: onUpdateInput,
        valueType: query.valueType,
        checkboxSettings: checkboxSettings,
        mustBeAccepted: mustBeAccepted,
      );
    }

    return Row(
      children: [
        if (checkboxSettings != null) Checkbox(value: checkboxSettings!.isChecked, onChanged: checkboxSettings!.onUpdateCheckbox),
        Expanded(
          child: IdentityAttributeValueRenderer(
            value: selectedAttribute is IdentityAttribute ? selectedAttribute.value : query.results.first.value as IdentityAttributeValue,
            valueHints: query.results.first.valueHints,
            trailing: onUpdateAttribute == null
                ? null
                : SizedBox(
                    width: 50,
                    child: IconButton(
                      onPressed: () => onUpdateAttribute!(query.valueType),
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class ProcessedRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedRelationshipAttributeQueryDVO query;
  final RequestRendererController? controller;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
  final CheckboxSettings? checkboxSettings;
  final void Function({String? valueType, ValueRendererInputValue? inputValue, required bool isComplex}) onUpdateInput;
  final bool mustBeAccepted;

  const ProcessedRelationshipAttributeQueryRenderer({
    super.key,
    required this.query,
    this.controller,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.checkboxSettings,
    required this.onUpdateInput,
    required this.mustBeAccepted,
  });

  @override
  Widget build(BuildContext context) {
    final selectedAttribute = this.selectedAttribute;

    if (query.results.isEmpty) {
      return ValueRendererListTile(
        fieldName: query.name,
        renderHints: query.renderHints,
        valueHints: query.valueHints,
        checkboxSettings: checkboxSettings,
        onUpdateInput: onUpdateInput,
        valueType: query.valueType,
        mustBeAccepted: mustBeAccepted,
      );
    }

    return Row(
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
          ),
        ),
      ],
    );
  }
}

class ProcessedThirdPartyRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedThirdPartyRelationshipAttributeQueryDVO query;
  final CheckboxSettings? checkboxSettings;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function()? onUpdateAttribute;

  const ProcessedThirdPartyRelationshipAttributeQueryRenderer({
    super.key,
    required this.query,
    this.checkboxSettings,
    this.selectedAttribute,
    this.onUpdateAttribute,
  });

  @override
  Widget build(BuildContext context) {
    final selectedAttribute = this.selectedAttribute;

    return Row(
      children: [
        if (checkboxSettings != null)
          Checkbox(value: checkboxSettings!.isChecked, onChanged: query.results.isEmpty ? null : checkboxSettings!.onUpdateCheckbox),
        if (selectedAttribute != null || query.results.isNotEmpty)
          Expanded(
            child: RelationshipAttributeValueRenderer(
              value: selectedAttribute is RelationshipAttribute ? selectedAttribute.value : query.results.first.value as RelationshipAttributeValue,
              trailing: onUpdateAttribute == null
                  ? null
                  : SizedBox(
                      width: 50,
                      child: IconButton(
                        onPressed: () => onUpdateAttribute!(),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ),
            ),
          )
        else
          const TranslatedText(
            'i18n://dvo.attributeQuery.ThirdPartyRelationshipAttributeQuery.noResults',
            style: TextStyle(color: Colors.redAccent),
          ),
      ],
    );
  }
}