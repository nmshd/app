import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

import 'custom_list_tile.dart';

class ValueRendererListTile extends StatelessWidget {
  final String fieldName;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final InputDecoration? decoration;
  final AttributeValue? initialValue;
  final ValueRendererController? controller;
  final IdentityAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
  final String? valueType;
  final CheckboxSettings? checkboxSettings;

  const ValueRendererListTile({
    super.key,
    required this.fieldName,
    required this.renderHints,
    required this.valueHints,
    this.decoration,
    this.initialValue,
    this.controller,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.valueType,
    this.checkboxSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (checkboxSettings != null) Checkbox(value: checkboxSettings!.isChecked, onChanged: checkboxSettings!.onUpdateCheckbox),
          Expanded(
            child: ValueRenderer(
              fieldName: fieldName,
              renderHints: renderHints,
              valueHints: valueHints,
              initialValue: initialValue,
            ),
          ),
          SizedBox(
            width: 50,
            child: IconButton(
              onPressed: onUpdateAttribute != null && valueType != null ? () => onUpdateAttribute!(valueType!) : null,
              icon: const Icon(Icons.chevron_right),
            ),
          )
        ],
      ),
    );
  }
}
