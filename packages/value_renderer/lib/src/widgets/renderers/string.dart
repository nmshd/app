import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/inputs/datepicker_button.dart';
import 'package:value_renderer/src/widgets/inputs/dropdown_select_button.dart';
import 'package:value_renderer/src/widgets/inputs/radio_button.dart';
import 'package:value_renderer/src/widgets/inputs/segmented_button_input.dart';
import 'package:value_renderer/src/widgets/inputs/text_input.dart';

class StringRenderer extends StatelessWidget {
  const StringRenderer({super.key, this.fieldName, this.values, this.editType, this.dataType, required this.initialValue, required this.valueHints});

  final Map<String, dynamic> initialValue;
  final List<ValueHintsValue>? values;
  final String? fieldName;
  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final ValueHints valueHints;

  @override
  Widget build(BuildContext context) {
    final int max = valueHints.max ?? 100;

    if (dataType == RenderHintsDataType.DateTime || dataType == RenderHintsDataType.Date || dataType == RenderHintsDataType.Time) {
      return const DatepickerButton();
    }
    if (editType == RenderHintsEditType.SelectLike) {
      return DropdownSelectButton(
        fieldName: fieldName!,
        initialValue: initialValue['value'],
        values: values,
      );
    }
    if (editType == RenderHintsEditType.ButtonLike) {
      return RadioButton(
        fieldName: fieldName!,
        values: values!,
        initialValue: initialValue['value'],
      );
    }
    if (editType == RenderHintsEditType.SliderLike) {
      return SegmentedButtonInput(
        fieldName: fieldName!,
        values: values ?? [],
        initialValue: initialValue['value'],
      );
    }
    return TextInput(
      fieldName: fieldName,
      initialValue: initialValue['value'] ?? '',
      max: max,
    );
  }
}
