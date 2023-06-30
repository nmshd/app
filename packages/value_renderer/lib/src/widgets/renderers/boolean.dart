import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/inputs/checkbox_button.dart';
import 'package:value_renderer/src/widgets/inputs/dropdown_select_button.dart';
import 'package:value_renderer/src/widgets/inputs/radio_button.dart';
import 'package:value_renderer/src/widgets/inputs/slider_input.dart';

class BooleanRenderer extends StatelessWidget {
  const BooleanRenderer({super.key, this.editType, this.dataType, this.valueHintsValue});

  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final bool? valueHintsValue;

  @override
  Widget build(BuildContext context) {
    if (editType == RenderHintsEditType.SelectLike) {
      return const DropdownSelectButton();
    }
    if (editType == RenderHintsEditType.SliderLike) {
      return const SliderInput();
    }
    if (valueHintsValue == true) {
      return const CheckboxButton();
    }
    return const RadioButton();
  }
}
