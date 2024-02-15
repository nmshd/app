import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../inputs/inputs.dart';
import '../value_renderer_controller.dart';

class NumberRenderer extends StatelessWidget {
  final ValueRendererController? controller;
  final RenderHintsDataType? dataType;
  final InputDecoration? decoration;
  final RenderHintsEditType? editType;
  final String fieldName;
  final AttributeValue? initialValue;
  final bool mustBeFilledOut;
  final RenderHintsTechnicalType technicalType;
  final ValueHints valueHints;
  final List<ValueHintsValue>? values;

  const NumberRenderer({
    super.key,
    this.controller,
    this.decoration,
    this.dataType,
    this.editType,
    required this.fieldName,
    required this.initialValue,
    required this.mustBeFilledOut,
    required this.technicalType,
    required this.valueHints,
    this.values,
  });

  @override
  Widget build(BuildContext context) {
    final min = valueHints.min;
    final max = valueHints.max;
    final pattern = valueHints.pattern;

    final json = initialValue?.toJson();
    if (json != null && json['value'] != null && json['value'] is! num) {
      throw Exception('trying to render an initial value with a non-Number value');
    }

    final num? initialNumberValue = initialValue?.toJson()['value'];
    final valueHintsDefaultValue = initialNumberValue != null ? ValueHintsDefaultValueNum(initialNumberValue) : null;

    if (editType == RenderHintsEditType.SelectLike && (values != null && values!.isNotEmpty)) {
      return DropdownSelectInput(
        controller: controller,
        decoration: decoration,
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        mustBeFilledOut: mustBeFilledOut,
        technicalType: technicalType,
        values: values!,
      );
    }

    if (editType == RenderHintsEditType.SelectLike) {
      // Replacing UI5's Rating Indicator
      // (https://sapui5.hana.ondemand.com/#/entity/sap.m.RatingIndicator/sample/sap.m.sample.RatingIndicator)
      // with a SliderInput for now, for simplicity
      return SliderInput(
        controller: controller,
        fieldName: fieldName,
        initialValue: initialNumberValue,
        min: 1,
        max: 5,
        technicalType: technicalType,
      );
    }

    if (editType == RenderHintsEditType.ButtonLike && (values != null && values!.isNotEmpty)) {
      return RadioInput(
        controller: controller,
        decoration: decoration,
        fieldName: fieldName,
        mustBeFilledOut: mustBeFilledOut,
        technicalType: technicalType,
        values: values!,
        initialValue: valueHintsDefaultValue,
      );
    }

    if (editType == RenderHintsEditType.ButtonLike) {
      // Replacing UI5's StepInput
      // (https://sapui5.hana.ondemand.com/#/entity/sap.ui.webc.main.StepInput/sample/sap.ui.webc.main.sample.StepInput)
      // with a normal NumberInput for now, for simplicity
      return NumberInput(
        controller: controller,
        decoration: decoration,
        fieldName: fieldName,
        values: values,
        initialValue: initialNumberValue,
        max: max,
        mustBeFilledOut: mustBeFilledOut,
        technicalType: technicalType,
      );
    }

    if (editType == RenderHintsEditType.InputLike && (values != null && values!.isNotEmpty)) {
      return NumberInput(
        controller: controller,
        decoration: decoration,
        fieldName: fieldName,
        values: values!,
        initialValue: initialNumberValue,
        min: min,
        max: max,
        mustBeFilledOut: mustBeFilledOut,
        pattern: pattern,
        technicalType: technicalType,
      );
    }

    if (editType == RenderHintsEditType.SliderLike && (values != null && values!.isNotEmpty)) {
      return SegmentedButtonInput(
        controller: controller,
        decoration: decoration,
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        mustBeFilledOut: mustBeFilledOut,
        technicalType: technicalType,
        values: values!,
      );
    }

    if (editType == RenderHintsEditType.SliderLike) {
      if (min == null || max == null) throw Exception('trying to render a SliderInput without a min/max value');

      return SliderInput(
        controller: controller,
        fieldName: fieldName,
        initialValue: initialNumberValue,
        min: min,
        max: max,
        technicalType: technicalType,
      );
    }

    return NumberInput(
      controller: controller,
      decoration: decoration,
      fieldName: fieldName,
      initialValue: initialNumberValue,
      max: max,
      mustBeFilledOut: mustBeFilledOut,
      pattern: pattern,
      technicalType: technicalType,
    );
  }
}
