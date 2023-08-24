import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../inputs/inputs.dart';

class BooleanRenderer extends StatelessWidget {
  final RenderHintsDataType? dataType;
  final RenderHintsEditType? editType;
  final String fieldName;
  final AttributeValue? initialValue;
  final List<ValueHintsValue>? values;

  const BooleanRenderer({
    super.key,
    this.dataType,
    this.editType,
    required this.fieldName,
    this.initialValue,
    this.values,
  });

  @override
  Widget build(BuildContext context) {
    final ValueHintsDefaultValue valueHintsDefaultValue;

    // TODO: handle this properly
    final json = initialValue?.toJson();
    if (json == null || json['value'] == null) {
      throw Exception('trying to render an initial value with no value field as a Bool value');
    }

    final initialBoolValue = initialValue?.toJson()['value'];
    if (initialBoolValue is bool) {
      valueHintsDefaultValue = ValueHintsDefaultValueBool(initialBoolValue);
    } else {
      valueHintsDefaultValue = ValueHintsDefaultValueString(initialBoolValue);
    }

    if (editType == RenderHintsEditType.ButtonLike && (values != null && values!.isNotEmpty)) {
      return RadioInput(
        fieldName: fieldName,
        values: values!,
        initialValue: valueHintsDefaultValue,
      );
    }

    if (editType == RenderHintsEditType.SliderLike && (values != null && values!.isNotEmpty)) {
      return SegmentedButtonInput(
        fieldName: fieldName,
        values: values!,
        initialValue: valueHintsDefaultValue,
      );
    }

    if (editType == RenderHintsEditType.SelectLike && (values != null && values!.isNotEmpty)) {
      return DropdownSelectInput(
        fieldName: fieldName,
        initialValue: valueHintsDefaultValue,
        values: values!,
      );
    }

    if (editType == RenderHintsEditType.SliderLike) {
      return SwitchInput(
        fieldName: fieldName,
        initialValue: initialBoolValue,
      );
    }

    return CheckboxInput(
      fieldName: fieldName,
      initialValue: initialBoolValue,
      values: values,
    );
  }
}
