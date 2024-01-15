import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

import 'custom_list_tile.dart';

class ValueRendererListTile extends StatefulWidget {
  final String fieldName;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final InputDecoration? decoration;
  final AttributeValue? initialValue;
  final ValueRendererController? controller;
  final void Function({String? valueType, dynamic inputValue, required bool isComplex}) onUpdateInput;
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
    this.valueType,
    this.checkboxSettings,
    required this.onUpdateInput,
  });

  @override
  State<ValueRendererListTile> createState() => _ValueRendererListTileState();
}

class _ValueRendererListTileState extends State<ValueRendererListTile> {
  final ValueRendererController controller = ValueRendererController();
  dynamic inputValue;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() => inputValue = controller.value);

      widget.onUpdateInput(
        inputValue: inputValue,
        valueType: widget.valueType,
        isComplex: widget.renderHints.editType == RenderHintsEditType.Complex ? true : false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (widget.checkboxSettings != null)
            Checkbox(value: widget.checkboxSettings!.isChecked, onChanged: widget.checkboxSettings!.onUpdateCheckbox),
          Expanded(
            child: ValueRenderer(
              fieldName: widget.fieldName,
              renderHints: widget.renderHints,
              valueHints: widget.valueHints,
              initialValue: widget.initialValue,
              valueType: widget.valueType,
              controller: controller,
            ),
          ),
          const SizedBox(width: 50)
        ],
      ),
    );
  }
}
