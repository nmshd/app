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
  final bool shouldTranslate;

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
    this.shouldTranslate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValueRenderer(
            fieldName: fieldName,
            renderHints: renderHints,
            valueHints: valueHints,
            initialValue: initialValue,
            shouldTranslate: shouldTranslate,
          ),
        ),
        SizedBox(width: 50, child: trailing ?? IconButton(onPressed: onPressed, icon: const Icon(Icons.chevron_right)))
      ],
    );
  }
}
