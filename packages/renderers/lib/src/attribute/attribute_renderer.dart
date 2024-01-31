import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'identity_attribute_value_renderer.dart';
import 'relationship_attribute_value_renderer.dart';

class AttributeRenderer extends StatelessWidget {
  final AbstractAttribute attribute;
  final ValueHints valueHints;
  final Widget? trailing;

  const AttributeRenderer({
    super.key,
    required this.attribute,
    required this.valueHints,
    this.trailing,
  });

  factory AttributeRenderer.localAttribute({required LocalAttributeDVO attribute, Widget? trailing}) => AttributeRenderer(
        attribute: attribute.content,
        valueHints: attribute.valueHints,
        trailing: trailing,
      );

  @override
  Widget build(BuildContext context) {
    final attribute = this.attribute;

    if (attribute is IdentityAttribute) {
      return IdentityAttributeValueRenderer(
        value: attribute.value,
        valueHints: valueHints,
        trailing: trailing,
      );
    }

    if (attribute is RelationshipAttribute) {
      return RelationshipAttributeValueRenderer(
        value: attribute.value,
        trailing: trailing,
      );
    }

    throw Exception('Unknown AbstractAttribute: ${attribute.runtimeType}');
  }
}
