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
  final VoidCallback? onPressed;

  const ValueRendererListTile({
    super.key,
    required this.fieldName,
    required this.renderHints,
    required this.valueHints,
    this.decoration,
    this.initialValue,
    this.controller,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ValueRenderer(
              fieldName: fieldName,
              renderHints: renderHints,
              valueHints: valueHints,
              initialValue: initialValue,
            ),
          ),
          SizedBox(width: 50, child: IconButton(onPressed: onPressed, icon: const Icon(Icons.chevron_right)))
        ],
      ),
    );
  }
}
