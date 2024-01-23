import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/src/renderers/request_item_renderer/widgets/attribute_renderer.dart';

import '../../widgets/custom_list_tile.dart';

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

    return AttributeRenderer(
        attribute: attributeContent,
        isRejected: isRejected,
        checkboxSettings: checkboxSettings,
        selectedAttribute: selectedAttribute,
        onUpdateAttribute: onUpdateAttribute);
  }
}
