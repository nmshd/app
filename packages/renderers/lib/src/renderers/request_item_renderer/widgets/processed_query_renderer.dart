import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../widgets/request_renderer_controller.dart';
import '../../widgets/value_renderer_list_tile.dart';
import 'identity_attribute_value_renderer.dart';

class ProcessedIdentityAttributeQueryRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final RequestRendererController? controller;

  const ProcessedIdentityAttributeQueryRenderer({super.key, required this.query, this.controller});

  @override
  Widget build(BuildContext context) {
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
      );
    }
    return IdentityAttributeValueRenderer(value: query.results.first.value as IdentityAttributeValue);
  }
}

class ProcessedRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedRelationshipAttributeQueryDVO query;
  final RequestRendererController? controller;

  const ProcessedRelationshipAttributeQueryRenderer({super.key, required this.query, this.controller});

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
      ],
    );
  }
}
