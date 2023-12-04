import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class ValueRendererListTile extends StatelessWidget {
  final String fieldName;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final InputDecoration? decoration;
  final AttributeValue? initialValue;
  final ValueRendererController? controller;
  final Function(bool?)? onUpdateCheckbox;
  final bool? isChecked;
  final bool? hideCheckbox;
  final IdentityAttribute? selectedAttribute;
  final Future<void> Function(String valueType)? onUpdateAttribute;
  final String? valueType;

  const ValueRendererListTile({
    super.key,
    required this.fieldName,
    required this.renderHints,
    required this.valueHints,
    this.decoration,
    this.initialValue,
    this.controller,
    this.onUpdateCheckbox,
    this.isChecked,
    this.hideCheckbox,
    this.selectedAttribute,
    this.onUpdateAttribute,
    this.valueType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (hideCheckbox != null && !hideCheckbox!) Checkbox(value: isChecked, onChanged: onUpdateCheckbox),
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
