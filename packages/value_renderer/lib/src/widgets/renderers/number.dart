import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../inputs/inputs.dart';

class NumberRenderer extends StatelessWidget {
  final RenderHintsDataType? dataType;
  final RenderHintsEditType? editType;
  final String fieldName;
  final AttributeValue? initialValue;
  final ValueHints valueHints;
  final List<ValueHintsValue>? values;

  const NumberRenderer({
    super.key,
    required this.fieldName,
    this.values,
    this.editType,
    this.dataType,
    required this.initialValue,
    required this.valueHints,
  });

  @override
  Widget build(BuildContext context) {
    final min = valueHints.min;
    final max = valueHints.max;

    if (dataType == RenderHintsDataType.DateTime ||
        dataType == RenderHintsDataType.Date ||
        dataType == RenderHintsDataType.Time ||
        dataType == RenderHintsDataType.Day) {
      return DatepickerInput(
        fieldName: fieldName,
        initialValue: initialValue,
      );
    }

    // TODO: handle this properly
    final json = initialValue?.toJson();
    if (json == null || json['value'] == null || json['value'] is! num) {
      throw Exception('trying to render an initial value with no value field as a Number value');
    }

    final num initialNumberValue = initialValue?.toJson()['value'];
    final valueHintsDefaultValue = ValueHintsDefaultValueNum(initialNumberValue);

    if (editType == RenderHintsEditType.SelectLike && (values != null && values!.isNotEmpty)) {
      return DropdownSelectInput(
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        values: values!,
      );
    }

    // Replacing "Rating"
    if (editType == RenderHintsEditType.SelectLike) {
      return SliderInput(
        fieldName: fieldName,
        initialValue: initialNumberValue,
        min: 1,
        max: 5,
      );
    }

    if (editType == RenderHintsEditType.ButtonLike && (values != null && values!.isNotEmpty)) {
      return RadioInput(
        fieldName: fieldName,
        values: values!,
        initialValue: valueHintsDefaultValue,
      );
    }

    // Replacing "StepInput"
    if (editType == RenderHintsEditType.ButtonLike) {
      return NumberInput(
        fieldName: fieldName,
        values: values!,
        initialValue: initialNumberValue,
        max: max,
      );
    }

    if (editType == RenderHintsEditType.InputLike && (values != null && values!.isNotEmpty)) {
      return NumberInput(
        fieldName: fieldName,
        values: values!,
        initialValue: initialNumberValue,
        max: max,
      );
    }

    if (editType == RenderHintsEditType.SliderLike && (values != null && values!.isNotEmpty)) {
      return SegmentedButtonInput(
        fieldName: fieldName,
        values: values ?? [],
        initialValue: valueHintsDefaultValue,
      );
    }

    if (editType == RenderHintsEditType.SliderLike) {
      return SliderInput(
        fieldName: fieldName,
        initialValue: initialNumberValue,
        min: min,
        max: max,
      );
    }

    return NumberInput(
      fieldName: fieldName,
      initialValue: initialNumberValue,
      max: max,
    );
  }
}