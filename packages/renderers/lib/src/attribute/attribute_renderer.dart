import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'identity_attribute_value_renderer.dart';
import 'relationship_attribute_value_renderer.dart';

class AttributeRenderer extends StatelessWidget {
  final AbstractAttribute attribute;
  final ValueHints valueHints;
  final bool showTitle;
  final TextStyle valueTextStyle;
  final Widget? trailing;

  const AttributeRenderer({
    super.key,
    required this.attribute,
    required this.valueHints,
    this.showTitle = true,
    this.valueTextStyle = const TextStyle(fontSize: 16),
    this.trailing,
  });

  factory AttributeRenderer.localAttribute({
    required LocalAttributeDVO attribute,
    bool showTitle = true,
    TextStyle? valueTextStyle,
    Widget? trailing,
  }) =>
      AttributeRenderer(
        attribute: attribute.content,
        valueHints: attribute.valueHints,
        showTitle: showTitle,
        valueTextStyle: valueTextStyle ?? const TextStyle(fontSize: 16),
        trailing: trailing,
      );

  @override
  Widget build(BuildContext context) {
    final attribute = this.attribute;

    if (attribute is IdentityAttribute) {
      return IdentityAttributeValueRenderer(
        value: attribute.value,
        valueHints: valueHints,
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        trailing: trailing,
      );
    }

    if (attribute is RelationshipAttribute) {
      return RelationshipAttributeValueRenderer(
        value: attribute.value,
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        trailing: trailing,
      );
    }

    throw Exception('Unknown AbstractAttribute: ${attribute.runtimeType}');
  }
}
