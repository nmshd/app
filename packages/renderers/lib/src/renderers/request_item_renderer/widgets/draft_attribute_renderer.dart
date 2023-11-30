import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'identity_attribute_value_renderer.dart';
import 'relationship_attribute_value_renderer.dart';

class DraftAttributeRenderer extends StatelessWidget {
  final DraftAttributeDVO draftAttribute;
  final bool? isRejected;
  final Function(bool?)? onUpdateCheckbox;
  final bool? isChecked;
  final bool? hideCheckbox;
  final AbstractAttribute? selectedAttribute;

  const DraftAttributeRenderer({
    super.key,
    required this.draftAttribute,
    this.isRejected,
    this.onUpdateCheckbox,
    this.isChecked,
    this.hideCheckbox,
    this.selectedAttribute,
  });

  @override
  Widget build(BuildContext context) {
    final attributeContent = switch (draftAttribute) {
      final DraftIdentityAttributeDVO item => item.content,
      final DraftRelationshipAttributeDVO item => item.content,
    };

    if (attributeContent is IdentityAttribute) {
      return IdentityAttributeValueRenderer(
        value: attributeContent.value,
        isRejected: isRejected,
        isChecked: isChecked,
        onUpdateCheckbox: onUpdateCheckbox,
        hideCheckbox: hideCheckbox,
        selectedAttribute: selectedAttribute != null ? selectedAttribute as IdentityAttribute : null,
      );
    }

    if (attributeContent is RelationshipAttribute) {
      return RelationshipAttributeValueRenderer(
        value: attributeContent.value,
        isRejected: isRejected,
        isChecked: isChecked,
        onUpdateCheckbox: onUpdateCheckbox,
        hideCheckbox: hideCheckbox,
        selectedAttribute: selectedAttribute != null ? selectedAttribute as RelationshipAttribute : null,
      );
    }

    throw Exception('Unknown AbstractAttribute: ${draftAttribute.runtimeType}');
  }
}
