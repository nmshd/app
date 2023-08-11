import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../inputs/inputs.dart';

class StringRenderer extends StatelessWidget {
  final Map<String, dynamic>? initialValue;
  final List<ValueHintsValue>? values;
  final String fieldName;
  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final ValueHints valueHints;

  const StringRenderer(
      {super.key, required this.fieldName, this.values, this.editType, this.dataType, required this.initialValue, required this.valueHints});

  @override
  Widget build(BuildContext context) {
    final int max = valueHints.max ?? 100;

    if (dataType == RenderHintsDataType.DateTime || dataType == RenderHintsDataType.Date || dataType == RenderHintsDataType.Time) {
      return DatepickerInput(
        fieldName: fieldName,
        initialValue: initialValue,
      );
    }

    if (editType == RenderHintsEditType.SelectLike) {
      return DropdownSelectInput(
        fieldName: fieldName,
        initialValue: initialValue?['value'],
        values: values,
      );
    }

    if (editType == RenderHintsEditType.ButtonLike && (values != null && values!.isNotEmpty)) {
      return RadioInput(
        fieldName: fieldName,
        values: values!,
        initialValue: initialValue?['value'],
      );
    }

    // Replacing "StepInput"
    if (editType == RenderHintsEditType.ButtonLike) {
      return TextInput(
        fieldName: fieldName,
        values: values!,
        initialValue: initialValue?['value'],
      );
    }

    if (editType == RenderHintsEditType.SliderLike) {
      return SegmentedButtonInput(
        fieldName: fieldName,
        values: values ?? [],
        initialValue: initialValue?['value'],
      );
    }

    if (editType == RenderHintsEditType.InputLike && (values != null && values!.isNotEmpty)) {
      return TextInput(
        fieldName: fieldName,
        values: values ?? [],
        initialValue: initialValue?['value'],
        max: max,
      );
    }

    return TextInput(
      fieldName: fieldName,
      initialValue: initialValue?['value'] ?? '',
      max: max,
    );
  }
}
