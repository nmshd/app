import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../value_renderer.dart';
import '../inputs/inputs.dart';

class BooleanRenderer extends StatelessWidget {
  final ValueRendererController? controller;
  final RenderHintsDataType? dataType;
  final RenderHintsEditType? editType;
  final String fieldName;
  final AttributeValue? initialValue;
  final RenderHintsTechnicalType? technicalType;
  final List<ValueHintsValue>? values;

  const BooleanRenderer({
    super.key,
    this.controller,
    this.dataType,
    this.editType,
    required this.fieldName,
    this.initialValue,
    this.technicalType,
    this.values,
  });

  @override
  Widget build(BuildContext context) {
    final json = initialValue?.toJson();
    if (json != null && json['value'] != null && json['value'] is! bool) {
      throw Exception('trying to render an initial value with a non-boolean value');
    }

    final initialBoolValue = initialValue?.toJson()['value'];
    final valueHintsDefaultValue = ValueHintsDefaultValueBool(initialBoolValue);

    if (editType == RenderHintsEditType.ButtonLike && (values != null && values!.isNotEmpty)) {
      return RadioInput(
        controller: controller,
        fieldName: fieldName,
        technicalType: technicalType,
        values: values!,
        initialValue: valueHintsDefaultValue,
      );
    }

    if (editType == RenderHintsEditType.SliderLike && (values != null && values!.isNotEmpty)) {
      return SegmentedButtonInput(
        controller: controller,
        fieldName: fieldName,
        technicalType: technicalType,
        values: values!,
        initialValue: valueHintsDefaultValue,
      );
    }

    if (editType == RenderHintsEditType.SelectLike && (values != null && values!.isNotEmpty)) {
      return DropdownSelectInput(
        controller: controller,
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        technicalType: technicalType,
        values: values!,
      );
    }

    if (editType == RenderHintsEditType.SliderLike) {
      return SwitchInput(
        controller: controller,
        fieldName: fieldName,
        initialValue: initialBoolValue,
      );
    }

    return CheckboxInput(
      controller: controller,
      fieldName: fieldName,
      initialValue: initialBoolValue,
      values: values,
    );
  }
}
