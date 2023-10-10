import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:translated_text/translated_text.dart';
import 'package:value_renderer/value_renderer.dart';

import '../../../../request_renderer.dart';
import 'identity_attribute_value_renderer.dart';
import 'relationship_attribute_value_renderer.dart';

class ProcessedIdentityAttributeQueryRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final RequestRendererController? controller;

  const ProcessedIdentityAttributeQueryRenderer({super.key, required this.query, this.controller});

  @override
  Widget build(BuildContext context) {
    return query.results.isEmpty
        ? ValueRenderer(fieldName: query.valueType, renderHints: query.renderHints, valueHints: query.valueHints)
        : switch (query.results.first.value) {
            final IdentityAttributeValue value => IdentityAttributeValueRenderer(results: query.results, value: value, controller: controller),
            final RelationshipAttributeValue value => RelationshipAttributeValueRenderer(results: query.results, value: value),
            _ => throw Exception('Unknown AttributeValue: ${query.results.first.valueType}'),
          };
  }
}

class ProcessedRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedRelationshipAttributeQueryDVO query;

  const ProcessedRelationshipAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TranslatedText(query.name),
        Text(query.type),
        // Text(query.valueType),
        Text(query.owner.name),
        Text(query.attributeCreationHints.title),
        //ValueRenderer(fieldName: query.valueType, renderHints: query.renderHints, valueHints: query.valueHints),
      ],
    );
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
