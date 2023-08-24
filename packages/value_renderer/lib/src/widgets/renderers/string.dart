import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../inputs/inputs.dart';

class StringRenderer extends StatelessWidget {
  final RenderHintsDataType? dataType;
  final RenderHintsEditType? editType;
  final String fieldName;
  final AttributeValue? initialValue;
  final ValueHints valueHints;
  final List<ValueHintsValue>? values;

  const StringRenderer({
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
    final max = valueHints.max;

    if (dataType == RenderHintsDataType.DateTime || dataType == RenderHintsDataType.Date || dataType == RenderHintsDataType.Time) {
      return DatepickerInput(
        fieldName: fieldName,
        initialValue: initialValue,
      );
    }

    final json = initialValue?.toJson();
    if (json != null && json['value'] != null && json['value'] is! String) {
      throw Exception('trying to render an initial value with a non-String value');
    }

    final String? initialStringValue = initialValue?.toJson()['value'];
    final valueHintsDefaultValue = initialStringValue == null ? null : ValueHintsDefaultValueString(initialStringValue);

    if (editType == RenderHintsEditType.SelectLike && (values != null && values!.isNotEmpty)) {
      return DropdownSelectInput(
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        values: values!,
      );
    }

    if (editType == RenderHintsEditType.ButtonLike && (values != null && values!.isNotEmpty)) {
      return RadioInput(
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        values: values!,
      );
    }

    if (editType == RenderHintsEditType.ButtonLike) {
      // Replacing UI5's StepInput
      // (https://sapui5.hana.ondemand.com/#/entity/sap.ui.webc.main.StepInput/sample/sap.ui.webc.main.sample.StepInput)
      // with a normal TextInput for now, for simplicity
      return TextInput(
        fieldName: fieldName,
        initialValue: initialStringValue,
        values: values,
      );
    }

    if (editType == RenderHintsEditType.SliderLike && (values != null && values!.isNotEmpty)) {
      return SegmentedButtonInput(
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        values: values!,
      );
    }

    if (editType == RenderHintsEditType.InputLike && (values != null && values!.isNotEmpty)) {
      return TextInput(
        fieldName: fieldName,
        initialValue: initialStringValue,
        values: values!,
        max: max,
      );
    }

    return TextInput(
      fieldName: fieldName,
      initialValue: initialStringValue,
      max: max,
    );
  }
}
