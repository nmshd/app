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
  });

  final String? fieldName;
  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final Map<String, dynamic>? initialValue;
  final List<dynamic>? values;

  @override
  Widget build(BuildContext context) {
    if (dataType == RenderHintsDataType.DateTime ||
        dataType == RenderHintsDataType.Date ||
        dataType == RenderHintsDataType.Time ||
        initialValue?['@type'] == 'BirthDate') {
      return DatepickerButton(
        fieldName: fieldName,
        initialValue: initialValue,
      );
    }
    if (editType == RenderHintsEditType.SelectLike) {
      return DropdownSelectButton(
        fieldName: fieldName!,
        initialValue: initialValue?['value'],
        values: values,
      );
    }
    if (editType == RenderHintsEditType.ButtonLike) {
      return RadioButton(
        fieldName: fieldName!,
        values: values!,
        initialValue: initialValue?['value'],
      );
    }
    if (editType == RenderHintsEditType.SliderLike && !initialValue?['value'].isEmpty) {
      return const SegmentedButtonInput();
    }
    if (editType == RenderHintsEditType.SliderLike) {
      return const SliderInput();
    }
    return const NumberInput();
  }
}
