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
    this.dataType,
    this.editType,
    required this.fieldName,
    required this.initialValue,
    required this.valueHints,
    this.values,
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

    final json = initialValue?.toJson();
    if (json != null && json['value'] != null && json['value'] is! num) {
      throw Exception('trying to render an initial value with a non-Number value');
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

    if (editType == RenderHintsEditType.SelectLike) {
      // Replacing UI5's Rating Indicator
      // (https://sapui5.hana.ondemand.com/#/entity/sap.m.RatingIndicator/sample/sap.m.sample.RatingIndicator)
      // with a SliderInput for now, for simplicity
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

    if (editType == RenderHintsEditType.ButtonLike) {
      // Replacing UI5's StepInput
      // (https://sapui5.hana.ondemand.com/#/entity/sap.ui.webc.main.StepInput/sample/sap.ui.webc.main.sample.StepInput)
      // with a normal NumberInput for now, for simplicity
      return NumberInput(
        fieldName: fieldName,
        values: values,
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
        values: values!,
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
