import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../inputs/inputs.dart';

class BooleanRenderer extends StatelessWidget {
  final String fieldName;
  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final Map<String, dynamic>? initialValue;
  final List<ValueHintsValue>? values;

  const BooleanRenderer({super.key, this.fieldName = '', this.editType, this.dataType, this.initialValue, this.values});

  @override
  Widget build(BuildContext context) {
    if (editType == RenderHintsEditType.ButtonLike && (values != null && values!.isNotEmpty)) {
      return RadioInput(
        fieldName: fieldName,
        values: values ?? [],
        initialValue: initialValue?['value'].toString(),
      );
    }

    if (editType == RenderHintsEditType.SliderLike && (values != null && values!.isNotEmpty)) {
      return SegmentedButtonInput(
        fieldName: fieldName,
        values: values ?? [],
        initialValue: initialValue?['value'].toString(),
      );
    }

    if (editType == RenderHintsEditType.SelectLike) {
      return DropdownSelectInput(
        fieldName: fieldName,
        initialValue: initialValue?['value'].toString(),
        values: values,
      );
    }

    if (editType == RenderHintsEditType.SliderLike) {
      return SwitchInput(
        fieldName: fieldName,
        initialValue: initialValue?['value'],
      );
    }

    return CheckboxInput(
      fieldName: fieldName,
      values: values ?? [],
      initialValue: initialValue?['value'],
    );
  }
}
