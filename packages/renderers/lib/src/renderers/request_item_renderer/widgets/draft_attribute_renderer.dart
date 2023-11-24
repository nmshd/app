import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/src/renderers/request_item_renderer/widgets/relationship_attribute_value_renderer.dart';

import 'identity_attribute_value_renderer.dart';

class DraftAttributeRenderer extends StatelessWidget {
  final DraftAttributeDVO draftAttribute;
  final bool? isRejected;

  const DraftAttributeRenderer({super.key, required this.draftAttribute, this.isRejected});

  @override
  Widget build(BuildContext context) {
    final attributeContent = switch (draftAttribute) {
      final DraftIdentityAttributeDVO item => item.content,
      final DraftRelationshipAttributeDVO item => item.content,
    };

    if (attributeContent is IdentityAttribute) {
      return IdentityAttributeValueRenderer(value: attributeContent.value);
    }

    if (attributeContent is RelationshipAttribute) {
      return RelationshipAttributeValueRenderer(value: attributeContent.value);
    }

    throw Exception('Unknown AbstractAttribute: ${draftAttribute.runtimeType}');
  }
}
