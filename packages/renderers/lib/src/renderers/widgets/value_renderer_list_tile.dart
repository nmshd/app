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
  final Widget? trailing;
  final VoidCallback? onPressed;
  final void Function(bool?)? onUpdateCheckbox;
  final bool? isChecked;

  const ValueRendererListTile({
    super.key,
    required this.fieldName,
    required this.renderHints,
    required this.valueHints,
    this.decoration,
    this.initialValue,
    this.controller,
    this.trailing,
    this.onPressed,
    this.onUpdateCheckbox,
    this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: onUpdateCheckbox != null ? Checkbox(value: isChecked, onChanged: onUpdateCheckbox) : null,
      title: ValueRenderer(fieldName: fieldName, renderHints: renderHints, valueHints: valueHints),
      trailing: trailing ?? IconButton(onPressed: onPressed, icon: const Icon(Icons.info)),
    );
  }
}
