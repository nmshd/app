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
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: ValueRenderer(
        fieldName: fieldName,
        renderHints: renderHints,
        valueHints: valueHints,
        decoration: decoration ??
            const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(width: 1, color: Colors.blue),
              ),
              hintMaxLines: 150,
              errorMaxLines: 150,
              helperMaxLines: 150,
            ),
      ),
      trailing: trailing ?? IconButton(onPressed: onPressed, icon: const Icon(Icons.info)),
    );
  }
}
