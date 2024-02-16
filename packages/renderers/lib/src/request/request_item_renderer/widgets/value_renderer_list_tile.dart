import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

import '../../../checkbox_settings.dart';

class ValueRendererListTile extends StatefulWidget {
  final String fieldName;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final InputDecoration? decoration;
  final AttributeValue? initialValue;
  final ValueRendererController? controller;
  final void Function({String? valueType, ValueRendererInputValue? inputValue, required bool isComplex}) onUpdateInput;
  final String? valueType;
  final CheckboxSettings? checkboxSettings;
  final bool mustBeAccepted;

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
    required this.mustBeAccepted,
  });

  @override
  State<ValueRendererListTile> createState() => _ValueRendererListTileState();
}

class _ValueRendererListTileState extends State<ValueRendererListTile> {
  final ValueRendererController controller = ValueRendererController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      widget.onUpdateInput(
        inputValue: controller.value,
        valueType: widget.valueType,
        isComplex: widget.renderHints.editType == RenderHintsEditType.Complex ? true : false,
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.checkboxSettings != null)
          Checkbox(
            value: widget.checkboxSettings!.isChecked,
            onChanged: widget.checkboxSettings!.onUpdateCheckbox,
          ),
        Expanded(
          child: ValueRenderer(
            fieldName: widget.fieldName,
            renderHints: widget.renderHints,
            valueHints: widget.valueHints,
            initialValue: widget.initialValue,
            valueType: widget.valueType,
            controller: controller,
            mustBeFilledOut: widget.checkboxSettings?.isChecked ?? widget.mustBeAccepted,
          ),
        ),
        const SizedBox(width: 25)
      ],
    );
  }
}
