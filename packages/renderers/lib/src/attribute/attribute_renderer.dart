import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../checkbox_settings.dart';
import 'identity_attribute_value_renderer.dart';
import 'relationship_attribute_value_renderer.dart';

class AttributeRenderer extends StatelessWidget {
  final AbstractAttribute attribute;
  final bool? isRejected;
  final AbstractAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
  final CheckboxSettings? checkboxSettings;

  const AttributeRenderer({
    super.key,
    required this.attribute,
    this.isRejected,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.checkboxSettings,
  });

  @override
  Widget build(BuildContext context) {
    final attribute = this.attribute;

    if (attribute is IdentityAttribute) {
      return IdentityAttributeValueRenderer(
        value: attribute.value,
        isRejected: isRejected,
        checkboxSettings: checkboxSettings,
        selectedAttribute: selectedAttribute != null ? selectedAttribute as IdentityAttribute : null,
        onUpdateAttribute: onUpdateAttribute,
      );
    }

    if (attribute is RelationshipAttribute) {
      return RelationshipAttributeValueRenderer(
        value: attribute.value,
        isRejected: isRejected,
        checkboxSettings: checkboxSettings,
        selectedAttribute: selectedAttribute != null ? selectedAttribute as RelationshipAttribute : null,
        onUpdateAttribute: onUpdateAttribute,
      );
    }

    throw Exception('Unknown AbstractAttribute: ${attribute.runtimeType}');
  }
}
