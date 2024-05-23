import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'identity_attribute_value_renderer.dart';
import 'relationship_attribute_value_renderer.dart';

class AttributeRenderer extends StatelessWidget {
  final AbstractAttribute attribute;
  final ValueHints valueHints;
  final bool showTitle;
  final TextStyle valueTextStyle;
  final String? extraLine;
  final TextStyle? extraLineTextStyle;
  final Widget? trailing;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;

  const AttributeRenderer({
    super.key,
    required this.attribute,
    required this.valueHints,
    this.showTitle = true,
    this.valueTextStyle = const TextStyle(fontSize: 16),
    this.extraLine,
    this.extraLineTextStyle,
    this.trailing,
    required this.expandFileReference,
    required this.openFileDetails,
  });

  factory AttributeRenderer.localAttribute({
    required LocalAttributeDVO attribute,
    bool showTitle = true,
    TextStyle valueTextStyle = const TextStyle(fontSize: 16),
    String? extraLine,
    TextStyle? extraLineTextStyle,
    Widget? trailing,
    required Future<FileDVO> Function(String) expandFileReference,
    required void Function(FileDVO) openFileDetails,
  }) =>
      AttributeRenderer(
        attribute: attribute.content,
        valueHints: attribute.valueHints,
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        extraLine: extraLine,
        extraLineTextStyle: extraLineTextStyle,
        trailing: trailing,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
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
        extraLine: extraLine,
        extraLineTextStyle: extraLineTextStyle,
        trailing: trailing,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      );
    }

    if (attribute is RelationshipAttribute) {
      return RelationshipAttributeValueRenderer(
        value: attribute.value,
        showTitle: showTitle,
        valueTextStyle: valueTextStyle,
        trailing: trailing,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      );
    }

    throw Exception('Unknown AbstractAttribute: ${attribute.runtimeType}');
  }
}
