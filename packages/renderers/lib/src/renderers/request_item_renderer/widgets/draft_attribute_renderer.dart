import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'identity_attribute_value_renderer.dart';
import 'relationship_attribute_value_renderer.dart';

class DraftAttributeRenderer extends StatelessWidget {
  final DraftAttributeDVO draftAttribute;
  final VoidCallback? onEdit;
  final bool? isRejected;

  const DraftAttributeRenderer({super.key, required this.draftAttribute, this.onEdit, this.isRejected});

  @override
  Widget build(BuildContext context) {
    final attributeContent = switch (draftAttribute) {
      final DraftIdentityAttributeDVO item => item.content,
      final DraftRelationshipAttributeDVO item => item.content,
    };

    if (attributeContent is IdentityAttribute) {
      return IdentityAttributeValueRenderer(value: attributeContent.value, onEdit: onEdit);
    }

    if (attributeContent is RelationshipAttribute) {
      return RelationshipAttributeValueRenderer(value: attributeContent.value, onEdit: onEdit);
    }

    throw Exception('Unknown AbstractAttribute: ${draftAttribute.runtimeType}');
  }
}
