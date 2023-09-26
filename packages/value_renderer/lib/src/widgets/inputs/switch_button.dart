import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../value_renderer.dart';

class SwitchInput extends FormField<bool> {
  SwitchInput({
    Key? key,
    ValueRendererController? controller,
    required String fieldName,
    bool? initialValue,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (FormFieldState<bool> field) {
            controller?.value = field.value;

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
