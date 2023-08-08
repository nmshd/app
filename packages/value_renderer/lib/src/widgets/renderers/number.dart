import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/inputs/datepicker_button.dart';
import 'package:value_renderer/src/widgets/inputs/dropdown_select_button.dart';
import 'package:value_renderer/src/widgets/inputs/number_input.dart';
import 'package:value_renderer/src/widgets/inputs/radio_button.dart';
import 'package:value_renderer/src/widgets/inputs/segmented_button_input.dart';
import 'package:value_renderer/src/widgets/inputs/slider_input.dart';

class NumberRenderer extends StatelessWidget {
  const NumberRenderer({
    super.key,
    this.fieldName,
    this.values,
    this.editType,
    this.dataType,
    required this.initialValue,
    required this.valueHints,
  });

  final String? fieldName;
  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final Map<String, dynamic>? initialValue;
  final List<ValueHintsValue>? values;
  final ValueHints valueHints;

  @override
  Widget build(BuildContext context) {
    final double min = valueHints.min?.toDouble() ?? 1;
    final double max = valueHints.max?.toDouble() ?? 100;

    if (dataType == RenderHintsDataType.DateTime ||
        dataType == RenderHintsDataType.Date ||
        dataType == RenderHintsDataType.Time ||
        initialValue?['@type'] == 'BirthDate') {
      return DatepickerButton(
        fieldName: fieldName,
        initialValue: initialValue,
      );
    }
    if (editType == RenderHintsEditType.SelectLike && (values != null && values!.isNotEmpty)) {
      return DropdownSelectButton(
        fieldName: fieldName!,
        initialValue: initialValue?['value'],
        values: values,
      );
    }
    // Replacing "Rating"
    if (editType == RenderHintsEditType.SelectLike) {
      return SliderInput(
        fieldName: fieldName!,
        initialValue: initialValue?['value'].toDouble(),
        min: 1,
        max: 5,
      );
    }
    if (editType == RenderHintsEditType.ButtonLike && (values != null && values!.isNotEmpty)) {
      return RadioButton(
        fieldName: fieldName!,
        values: values!,
        initialValue: initialValue?['value'],
      );
    }
    if (editType == RenderHintsEditType.SliderLike && (values != null && values!.isNotEmpty)) {
      return SegmentedButtonInput(
        fieldName: fieldName!,
        values: values ?? [],
        initialValue: initialValue?['value'],
      );
    }
    if (editType == RenderHintsEditType.SliderLike) {
      return SliderInput(
        fieldName: fieldName,
        initialValue: initialValue?['value'].toDouble(),
        min: min,
        max: max,
      );
    }
    return NumberInput(
      initialValue: initialValue?['value'].toString(),
      fieldName: fieldName,
      max: max,
    );
  }
}
