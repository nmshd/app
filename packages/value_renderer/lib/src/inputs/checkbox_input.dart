import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '../utils/utils.dart';
import '../value_renderer_controller.dart';

class CheckboxInput extends FormField<bool> {
  CheckboxInput({
    super.key,
    bool autovalidate = false,
    ValueRendererController? controller,
    String? fieldName,
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
                title: fieldName != null ? TranslatedText(fieldName) : null,
                value: field.value,
                onChanged: field.didChange,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            );
          },
        );
}
