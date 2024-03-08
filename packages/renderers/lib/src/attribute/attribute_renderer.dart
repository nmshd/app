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
  final Future<FileDVO> Function(String) expandFileReference;

  const AttributeRenderer({
    super.key,
    required this.attribute,
    required this.valueHints,
    this.showTitle = true,
    this.valueTextStyle = const TextStyle(fontSize: 16),
    this.trailing,
    required this.expandFileReference,
  });

  factory AttributeRenderer.localAttribute({
    required LocalAttributeDVO attribute,
    bool showTitle = true,
    TextStyle valueTextStyle = const TextStyle(fontSize: 16),
    Widget? trailing,
    required Future<FileDVO> Function(String) expandFileReference,
  }) =>
      AttributeRenderer(
        attribute: attribute.content,
        valueHints: attribute.valueHints,
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        trailing: trailing,
        expandFileReference: expandFileReference,
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
        expandFileReference: expandFileReference,
      );
    }

    if (attribute is RelationshipAttribute) {
      return RelationshipAttributeValueRenderer(
        value: attribute.value,
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        trailing: trailing,
        expandFileReference: expandFileReference,
      );
    }

    throw Exception('Unknown AbstractAttribute: ${attribute.runtimeType}');
  }
}
