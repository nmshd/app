import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/inputs/checkbox_button.dart';
import 'package:value_renderer/src/widgets/inputs/dropdown_select_button.dart';
import 'package:value_renderer/src/widgets/inputs/radio_button.dart';
import 'package:value_renderer/src/widgets/inputs/segmented_button_input.dart';
import 'package:value_renderer/src/widgets/inputs/switch_button.dart';

class BooleanRenderer extends StatelessWidget {
  const BooleanRenderer({super.key, this.editType, this.dataType, this.valueHintsValue});

  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final bool? valueHintsValue;

  @override
  Widget build(BuildContext context) {
    if (editType == RenderHintsEditType.ButtonLike && valueHintsValue == true) {
      return const CheckboxButton();
    }
    if (editType == RenderHintsEditType.SliderLike && valueHintsValue == true) {
      return const SegmentedButtonInput();
    }
    if (editType == RenderHintsEditType.SelectLike) {
      return const DropdownSelectButton();
    }
    if (editType == RenderHintsEditType.SliderLike) {
      return const SwitchButton();
    }
    return const RadioButton();
  }
}
