import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_list_tile.dart';
import 'identity_attribute_value_renderer.dart';
import 'relationship_attribute_value_renderer.dart';

class DraftAttributeRenderer extends StatelessWidget {
  final DraftAttributeDVO draftAttribute;
  final bool? isRejected;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
  final CheckboxSettings? checkboxSettings;

  const DraftAttributeRenderer({
    super.key,
    required this.draftAttribute,
    this.isRejected,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.checkboxSettings,
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
        checkboxSettings: checkboxSettings,
        selectedAttribute: selectedAttribute != null ? selectedAttribute as IdentityAttribute : null,
        onUpdateAttribute: onUpdateAttribute,
      );
    }

    if (attributeContent is RelationshipAttribute) {
      return RelationshipAttributeValueRenderer(
        value: attributeContent.value,
        isRejected: isRejected,
        checkboxSettings: checkboxSettings,
        selectedAttribute: selectedAttribute != null ? selectedAttribute as RelationshipAttribute : null,
        onUpdateAttribute: onUpdateAttribute,
      );
    }

    throw Exception('Unknown AbstractAttribute: ${draftAttribute.runtimeType}');
  }
}
