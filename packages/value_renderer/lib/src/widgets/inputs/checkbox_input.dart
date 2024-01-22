import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../value_renderer.dart';
import '../utils/utils.dart';

class CheckboxInput extends FormField<bool> {
  CheckboxInput({
    super.key,
    bool autovalidate = false,
    ValueRendererController? controller,
    required String fieldName,
    ValueHintsDefaultValueBool? initialValue,
    super.onSaved,
    super.validator,
    InputDecoration? decoration,
  }) : super(
          initialValue: initialValue?.value ?? false,
          builder: (FormFieldState<bool> field) {
            if (field.value != null) controller?.value = ValueRendererInputValueBool(field.value!);
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
