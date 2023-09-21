import 'package:flutter/material.dart';

import '/value_renderer.dart';
import '../utils/translated_text.dart';

class CheckboxInput extends FormField<bool> {
  CheckboxInput({
    super.key,
    bool autovalidate = false,
    ValueRendererController? controller,
    required String fieldName,
    bool initialValue = false,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<bool> field) {
            controller?.value = field.value;
            return CheckboxListTile(
              title: TranslatedText(fieldName),
              value: field.value,
              onChanged: field.didChange,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}
