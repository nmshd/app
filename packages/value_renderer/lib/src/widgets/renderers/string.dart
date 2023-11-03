import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../value_renderer.dart';
import '../inputs/inputs.dart';

class StringRenderer extends StatelessWidget {
  final ValueRendererController? controller;
  final InputDecoration? decoration;
  final RenderHintsDataType? dataType;
  final RenderHintsEditType? editType;
  final String fieldName;
  final AttributeValue? initialValue;
  final RenderHintsTechnicalType technicalType;
  final ValueHints valueHints;
  final List<ValueHintsValue>? values;
  final bool shouldTranslate;

  const StringRenderer({
    super.key,
    this.controller,
    this.decoration,
    this.dataType,
    this.editType,
    required this.fieldName,
    required this.initialValue,
    required this.technicalType,
    required this.valueHints,
    this.values,
    required this.shouldTranslate,
  });

  @override
  Widget build(BuildContext context) {
    final fieldName = this.fieldName.startsWith('i18n://')
        ? this.fieldName
        : shouldTranslate
            ? 'i18n://dvo.attribute.name.${this.fieldName[0].toUpperCase() + this.fieldName.substring(1)}'
            : this.fieldName;
    final max = valueHints.max;
    final pattern = valueHints.pattern;

    final json = initialValue?.toJson();
    if (json != null && json['value'] != null && json['value'] is! String) {
      throw Exception('trying to render an initial value with a non-String value');
    }

    final String? initialStringValue = initialValue?.toJson()['value'];
    final valueHintsDefaultValue = initialStringValue == null ? null : ValueHintsDefaultValueString(initialStringValue);

    if (editType == RenderHintsEditType.SelectLike && (values != null && values!.isNotEmpty)) {
      return DropdownSelectInput(
        controller: controller,
        decoration: decoration,
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        technicalType: technicalType,
        values: values!,
      );
    }

    if (editType == RenderHintsEditType.ButtonLike && (values != null && values!.isNotEmpty)) {
      return RadioInput(
        controller: controller,
        decoration: decoration,
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        technicalType: technicalType,
        values: values!,
      );
    }

    if (editType == RenderHintsEditType.ButtonLike) {
      // Replacing UI5's StepInput
      // (https://sapui5.hana.ondemand.com/#/entity/sap.ui.webc.main.StepInput/sample/sap.ui.webc.main.sample.StepInput)
      // with a normal TextInput for now, for simplicity
      return TextInput(
        controller: controller,
        decoration: decoration,
        fieldName: fieldName,
        initialValue: initialStringValue,
        values: values,
      );
    }

    if (editType == RenderHintsEditType.SliderLike && (values != null && values!.isNotEmpty)) {
      return SegmentedButtonInput(
        controller: controller,
        decoration: decoration,
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        technicalType: technicalType,
        values: values!,
      );
    }

    if (editType == RenderHintsEditType.InputLike && (values != null && values!.isNotEmpty)) {
      return TextInput(
        controller: controller,
        decoration: decoration,
        fieldName: fieldName,
        initialValue: initialStringValue,
        max: max,
        pattern: pattern,
        values: values!,
      );
    }

    return TextInput(
      controller: controller,
      decoration: decoration,
      fieldName: fieldName,
      initialValue: initialStringValue,
      pattern: pattern,
      max: max,
    );
  }
}
