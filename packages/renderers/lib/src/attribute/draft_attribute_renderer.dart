import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/src/attribute/attribute_renderer.dart';
import '/src/checkbox_settings.dart';
import '/src/custom_list_tile.dart';

class DraftAttributeRenderer extends StatelessWidget {
  final DraftAttributeDVO draftAttribute;
  final bool? isRejected;
  final Future<void> Function(String valueType)? onUpdateAttribute;
  final CheckboxSettings? checkboxSettings;

  const DraftAttributeRenderer({
    super.key,
    required this.draftAttribute,
    this.isRejected,
    this.onUpdateAttribute,
    this.checkboxSettings,
  });

  @override
  Widget build(BuildContext context) {
    final attributeContent = switch (draftAttribute) {
      final DraftIdentityAttributeDVO item => item.content,
      final DraftRelationshipAttributeDVO item => item.content,
    };

    return Row(
      children: [
        if (checkboxSettings != null) Checkbox(value: checkboxSettings!.isChecked, onChanged: checkboxSettings!.onUpdateCheckbox),
        Expanded(
          child: isRejected ?? false
              ? CustomListTile(title: attributeContent.valueTypeAtTypeI18n)
              : AttributeRenderer(
                  attribute: attributeContent,
                  onUpdateAttribute: onUpdateAttribute,
                  valueHints: draftAttribute.valueHints,
                ),
        ),
      ],
    );
  }
}

extension _ValueTypeI18n on AbstractAttribute {
  String get valueTypeAtTypeI18n => switch (this) {
        final IdentityAttribute item => item.value.atType,
        final RelationshipAttribute item => item.value.atType,
        _ => throw Exception('Unknown AbstractAttribute: $runtimeType'),
      };
}
