import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../value_renderer.dart';
import '../utils/utils.dart';
import '../value_renderer_controller.dart';

class SwitchInput extends FormField<bool> {
  SwitchInput({
    super.key,
    ValueRendererController? controller,
    required String fieldName,
    super.initialValue,
    super.onSaved,
    super.validator,
  }) : super(
          builder: (FormFieldState<bool> field) {
            if (field.value != null) controller?.value = ValueRendererInputValueBool(field.value!);

            return Row(
              children: [
                TranslatedText(fieldName),
                Switch(
                  value: field.value ?? false,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {
                    controller?.value = value;
                    field.didChange(value);
                  },
                ),
              ],
            );
          },
        );
}
