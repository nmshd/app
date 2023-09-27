import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../value_renderer.dart';

class CheckboxInput extends FormField<bool> {
  CheckboxInput({
    super.key,
    bool autovalidate = false,
    ValueRendererController? controller,
    required String fieldName,
    bool initialValue = false,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    InputDecoration? decoration,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (FormFieldState<bool> field) {
            controller?.value = field.value;
            return InputDecorator(
              decoration: decoration ?? const InputDecoration(border: InputBorder.none),
              child: CheckboxListTile(
                title: TranslatedText(fieldName),
                value: field.value,
                onChanged: field.didChange,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            );
          },
        );
}
