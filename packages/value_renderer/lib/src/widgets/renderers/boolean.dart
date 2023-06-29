import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/inputs/dropdown_select_button.dart';
import 'package:value_renderer/src/widgets/inputs/radio_button.dart';

class BooleanRenderer extends StatelessWidget {
  const BooleanRenderer({super.key, this.editType, this.dataType});

  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;

  @override
  Widget build(BuildContext context) {
    if (editType == RenderHintsEditType.SelectLike) {
      return const DropdownSelectButton();
    }
    return const RadioButton();
  }
}
