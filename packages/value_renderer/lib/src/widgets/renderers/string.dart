import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/inputs/datepicker_button.dart';
import 'package:value_renderer/src/widgets/inputs/dropdown_select_button.dart';
import 'package:value_renderer/src/widgets/inputs/radio_button.dart';
import 'package:value_renderer/src/widgets/inputs/segmented_button_input.dart';
import 'package:value_renderer/src/widgets/inputs/text_input.dart';

class StringRenderer extends StatelessWidget {
  const StringRenderer({super.key, this.editType, this.dataType});

  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;

  @override
  Widget build(BuildContext context) {
    if (dataType == RenderHintsDataType.DateTime || dataType == RenderHintsDataType.Date || dataType == RenderHintsDataType.Time) {
      return const DatepickerButton();
    }
    if (editType == RenderHintsEditType.SelectLike) {
      return const DropdownSelectButton();
    }
    if (editType == RenderHintsEditType.ButtonLike) {
      return const RadioButton();
    }
    if (editType == RenderHintsEditType.SliderLike) {
      return const SegmentedButtonInput();
    }
    return const TextInput();
  }
}
