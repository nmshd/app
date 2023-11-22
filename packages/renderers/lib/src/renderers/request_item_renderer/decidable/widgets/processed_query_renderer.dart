import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../../../request_renderer.dart';
import '../../../widgets/value_renderer_list_tile.dart';
import 'identity_attribute_value_renderer.dart';

class ProcessedIdentityAttributeQueryRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const ProcessedIdentityAttributeQueryRenderer({super.key, required this.query, this.controller, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return query.results.isEmpty
        ? ValueRendererListTile(
            fieldName: switch (query.valueType) {
              'Affiliation' => 'i18n://attributes.values.${query.valueType}._title',
              'BirthDate' => 'i18n://attributes.values.${query.valueType}._title',
              'BirthPlace' => 'i18n://attributes.values.${query.valueType}._title',
              'DeliveryBoxAddress' => 'i18n://attributes.values.${query.valueType}._title',
              'PersonName' => 'i18n://attributes.values.${query.valueType}._title',
              'PostOfficeBoxAddress' => 'i18n://attributes.values.${query.valueType}._title',
              'StreetAddress' => 'i18n://attributes.values.${query.valueType}._title',
              _ => 'i18n://dvo.attribute.name.${query.valueType[0].toUpperCase() + query.valueType.substring(1)}',
            },
            renderHints: query.renderHints,
            valueHints: query.valueHints,
          )
        : IdentityAttributeValueRenderer(
            query: query,
            value: query.results.first.value as IdentityAttributeValue,
            controller: controller,
            onEdit: onEdit,
          );
  }
}

class ProcessedRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedRelationshipAttributeQueryDVO query;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const ProcessedRelationshipAttributeQueryRenderer({super.key, required this.query, this.controller, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ValueRendererListTile(fieldName: query.name, renderHints: query.renderHints, valueHints: query.valueHints);
  }
}

class ProcessedThirdPartyAttributeQueryRenderer extends StatelessWidget {
  final ProcessedThirdPartyRelationshipAttributeQueryDVO query;

  const ProcessedThirdPartyAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(query.type),
        TranslatedText(query.name),
        // owner, thirdParty ...
      ],
    );
  }
}
