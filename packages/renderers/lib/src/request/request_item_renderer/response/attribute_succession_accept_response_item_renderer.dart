import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/src/attribute/identity_attribute_value_renderer.dart';
import '/src/attribute/relationship_attribute_value_renderer.dart';

class AttributeSuccessionAcceptResponseItemRenderer extends StatelessWidget {
  final AttributeSuccessionAcceptResponseItemDVO item;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;

  const AttributeSuccessionAcceptResponseItemRenderer({
    super.key,
    required this.item,
    required this.expandFileReference,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    return switch (item.successor.value) {
      final IdentityAttributeValue value => IdentityAttributeValueRenderer(
          value: value,
          valueHints: item.successor.valueHints,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
        ),
      final RelationshipAttributeValue value => RelationshipAttributeValueRenderer(
          value: value,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
        ),
      _ => throw Exception('Unknown AttributeValue: ${item.successor.valueType}'),
    };
  }
}
