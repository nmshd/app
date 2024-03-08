import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/src/attribute/identity_attribute_value_renderer.dart';
import '/src/attribute/relationship_attribute_value_renderer.dart';

class ShareAttributeAcceptResponseItemRenderer extends StatelessWidget {
  final ShareAttributeAcceptResponseItemDVO item;
  final Future<FileDVO> Function(String) expandFileReference;

  const ShareAttributeAcceptResponseItemRenderer({super.key, required this.item, required this.expandFileReference});

  @override
  Widget build(BuildContext context) {
    return switch (item.attribute.value) {
      final IdentityAttributeValue value => IdentityAttributeValueRenderer(
          value: value,
          valueHints: item.attribute.valueHints,
          expandFileReference: expandFileReference,
        ),
      final RelationshipAttributeValue value => RelationshipAttributeValueRenderer(
          value: value,
          expandFileReference: expandFileReference,
        ),
      _ => throw Exception('Unknown AttributeValue: ${item.attribute.valueType}'),
    };
  }
}
