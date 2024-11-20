import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '/src/attribute/identity_attribute_value_renderer.dart';
import '/src/attribute/relationship_attribute_value_renderer.dart';
import '/src/checkbox_settings.dart';
import '../../widgets/value_renderer_list_tile.dart';

class ProcessedIdentityAttributeQueryRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
  final CheckboxSettings? checkboxSettings;
  final bool mustBeAccepted;

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
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    if (query.results.isEmpty) {
      return _EmptyAttribute(
        valueType: query.valueType,
        onCreateAttribute: () async {
          onUpdateAttribute!(query.valueType);
        },
      );
    }

    return Row(
      children: [
        if (checkboxSettings != null) Checkbox(value: checkboxSettings!.isChecked, onChanged: checkboxSettings!.onUpdateCheckbox),
        Expanded(
          child: IdentityAttributeValueRenderer(
            value: selectedAttribute != null ? (selectedAttribute as IdentityAttribute).value : query.results.first.value as IdentityAttributeValue,
            valueHints: query.valueHints,
            trailing: onUpdateAttribute == null
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (query.results.length > 1) Flexible(child: Text('+${query.results.length - 1}')),
                      IconButton(
                        onPressed: () => onUpdateAttribute!(query.valueType),
                        icon: const Icon(Icons.chevron_right),
                      )
                    ],
                  ),
            expandFileReference: expandFileReference,
            openFileDetails: openFileDetails,
          ),
        ),
      ],
    );
  }
}

class _EmptyAttribute extends StatelessWidget {
  final String valueType;
  final VoidCallback onCreateAttribute;

  const _EmptyAttribute({super.key, required this.valueType, required this.onCreateAttribute});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        tileColor: Theme.of(context).colorScheme.surface,
        title: TranslatedText(
          'i18n://dvo.attribute.name.$valueType',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        subtitle: Text(
          'Kein Eintrag',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outline),
        ),
        trailing: TextButton.icon(
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary, size: 20), label: Text('Anlegen'), onPressed: onCreateAttribute),
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

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

  const ProcessedRelationshipAttributeQueryRenderer({
    super.key,
    required this.query,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.checkboxSettings,
    required this.mustBeAccepted,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    final selectedAttribute = this.selectedAttribute;

    if (query.results.isEmpty) {
      // TODO: Use EmptyAttribute widget
      // return ValueRendererListTile(
      //   fieldName: query.name,
      //   renderHints: query.renderHints,
      //   valueHints: query.valueHints,
      //   checkboxSettings: checkboxSettings,
      //   valueType: query.valueType,
      //   mustBeAccepted: mustBeAccepted,
      //   expandFileReference: expandFileReference,
      //   chooseFile: chooseFile,
      //   openFileDetails: openFileDetails,
      // );
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
            expandFileReference: expandFileReference,
            openFileDetails: openFileDetails,
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
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;

  const ProcessedThirdPartyRelationshipAttributeQueryRenderer({
    super.key,
    required this.query,
    this.checkboxSettings,
    this.selectedAttribute,
    this.onUpdateAttribute,
    required this.expandFileReference,
    required this.openFileDetails,
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
  final void Function(FileDVO) openFileDetails;

  const ProcessedIQLQueryRenderer({
    super.key,
    required this.requestItemTitle,
    required this.query,
    this.checkboxSettings,
    this.selectedAttribute,
    this.onUpdateAttribute,
    required this.expandFileReference,
    required this.chooseFile,
    required this.mustBeAccepted,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    final selectedAttribute = this.selectedAttribute;

    if (query.results.isEmpty) {
      if (query.valueType != null && query.valueHints != null && query.renderHints != null) {
        if (query.valueType == 'IdentityFileReference') {
          return ValueRendererListTile(
            fieldName: requestItemTitle!,
            valueType: query.valueType!,
            mustBeAccepted: mustBeAccepted,
            onUpdateAttribute: onUpdateAttribute!,
            renderHints: query.renderHints!,
            valueHints: query.valueHints!,
            expandFileReference: (truncatedReference) => expandFileReference(truncatedReference),
            chooseFile: chooseFile,
            openFileDetails: openFileDetails,
          );
        } else {
          // TODO: use EmptyAttribute widget
          // why the hell are we using iql queries??
          // return ValueRendererListTile(
          //   fieldName: requestItemTitle ??
          //       switch (query.valueType) {
          //         'Affiliation' ||
          //         'BirthDate' ||
          //         'BirthPlace' ||
          //         'DeliveryBoxAddress' ||
          //         'PersonName' ||
          //         'PostOfficeBoxAddress' ||
          //         'StreetAddress' =>
          //           'i18n://attributes.values.${query.valueType}._title',
          //         _ => 'i18n://dvo.attribute.name.${query.valueType}',
          //       },
          //   renderHints: query.renderHints!,
          //   valueHints: query.valueHints!,
          //   // onUpdateInput: onUpdateAttribute!,
          //   valueType: query.valueType!,
          //   checkboxSettings: checkboxSettings,
          //   mustBeAccepted: mustBeAccepted,
          //   expandFileReference: expandFileReference,
          //   chooseFile: chooseFile,
          //   openFileDetails: openFileDetails,
          // );
          return _EmptyAttribute(
            valueType: query.valueType!,
            onCreateAttribute: () async {
              onUpdateAttribute!(query.valueType);
            },
          );
        }
      } else {
        return Row(
          children: [
            if (checkboxSettings != null) Checkbox(value: checkboxSettings!.isChecked, onChanged: null),
            TranslatedText('i18n://dvo.attributeQuery.IQLQuery.noResults', style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
        );
      }
    }

    return Row(
      children: [
        if (checkboxSettings != null) Checkbox(value: checkboxSettings!.isChecked, onChanged: checkboxSettings!.onUpdateCheckbox),
        Expanded(
          child: IdentityAttributeValueRenderer(
            titleOverride: requestItemTitle,
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
            expandFileReference: expandFileReference,
            openFileDetails: openFileDetails,
          ),
        ),
      ],
    );
  }
}
