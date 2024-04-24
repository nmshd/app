import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '../utils/utils.dart';
import '../value_renderer_controller.dart';

class SwitchInput extends FormField<bool> {
  SwitchInput({
    super.key,
    ValueRendererController? controller,
    String? fieldName,
    super.initialValue,
    super.onSaved,
    super.validator,
  }) : super(
          builder: (FormFieldState<bool> field) {
            if (field.value != null) controller?.value = ValueRendererInputValueBool(field.value!);

            return Row(
              children: [
                if (fieldName != null) TranslatedText(fieldName),
                Switch(
                  value: field.value ?? false,
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
