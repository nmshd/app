import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/src/attribute/identity_attribute_value_renderer.dart';
import '/src/attribute/relationship_attribute_value_renderer.dart';

class ShareAttributeAcceptResponseItemRenderer extends StatelessWidget {
  final ShareAttributeAcceptResponseItemDVO item;

  const ShareAttributeAcceptResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return switch (item.attribute.value) {
      final IdentityAttributeValue value => IdentityAttributeValueRenderer(value: value, valueHints: item.attribute.valueHints),
      final RelationshipAttributeValue value => RelationshipAttributeValueRenderer(value: value),
      _ => throw Exception('Unknown AttributeValue: ${item.attribute.valueType}'),
    };
  }
}
