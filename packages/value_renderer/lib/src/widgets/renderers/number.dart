import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/inputs/dropdown_select_button.dart';
import 'package:value_renderer/src/widgets/inputs/number_input.dart';
import 'package:value_renderer/src/widgets/inputs/radio_button.dart';
import 'package:value_renderer/src/widgets/inputs/segmented_button_input.dart';
import 'package:value_renderer/src/widgets/inputs/slider_input.dart';

class NumberRenderer extends StatelessWidget {
  const NumberRenderer({super.key, this.fieldName, this.editType, this.dataType, this.valueHintsValue});

  final String? fieldName;
  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final bool? valueHintsValue;

  @override
  Widget build(BuildContext context) {
    if (editType == RenderHintsEditType.SelectLike) {
      return const DropdownSelectButton();
    }
    if (editType == RenderHintsEditType.ButtonLike) {
      return const RadioButton();
    }
    if (editType == RenderHintsEditType.SliderLike && valueHintsValue == true) {
      return const SegmentedButtonInput();
    }
    if (editType == RenderHintsEditType.SliderLike) {
      return const SliderInput();
    }
    return const NumberInput();
  }
}
