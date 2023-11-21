import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../widgets/identity_attribute_value_renderer.dart';
import '../widgets/relationship_attribute_value_renderer.dart';

class ReadAttributeAcceptResponseItemRenderer extends StatelessWidget {
  final ReadAttributeAcceptResponseItemDVO item;

  const ReadAttributeAcceptResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return switch (item.attribute.value) {
      final IdentityAttributeValue value => IdentityAttributeValueRenderer(value: value),
      final RelationshipAttributeValue value => RelationshipAttributeValueRenderer(value: value),
      _ => throw Exception('Unknown AttributeValue: ${item.attribute.valueType}'),
    };
  }
}
