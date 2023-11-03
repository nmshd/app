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
        ? Column(
            children: [
              ValueRendererListTile(fieldName: query.valueType, renderHints: query.renderHints, valueHints: query.valueHints),
              const SizedBox(height: 16),
            ],
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
    return Column(
      children: [
        ValueRendererListTile(fieldName: query.name, renderHints: query.renderHints, valueHints: query.valueHints, shouldTranslate: false),
        const SizedBox(height: 16),
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
