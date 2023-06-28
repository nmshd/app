import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/dropdown_select_button.dart';
import 'package:value_renderer/src/widgets/number_input.dart';
import 'package:value_renderer/src/widgets/radio_button.dart';
import 'package:value_renderer/src/widgets/text_input.dart';

class WidgetStore extends StatelessWidget {
  const WidgetStore({super.key, this.technicalType, this.editType});

  final RenderHintsTechnicalType? technicalType;
  final RenderHintsEditType? editType;

  @override
  Widget build(BuildContext context) {
    if (technicalType == RenderHintsTechnicalType.String) {
      return const TextInput();
    }
    if (technicalType == RenderHintsTechnicalType.Boolean) {
      return const RadioButton();
    }
    if (technicalType == RenderHintsTechnicalType.Integer) {
      return const NumberInput();
    }
    if (technicalType == RenderHintsTechnicalType.Integer) {
      return const NumberInput();
    }
    if (editType == RenderHintsEditType.SelectLike) {
      return const DropdownSelectButton();
    } else {
      return const TextInput();
    }
  }
}
