import 'package:flutter/material.dart';

import '/value_renderer.dart';
import '../utils/translated_text.dart';

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
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
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
