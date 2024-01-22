import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../utils/utils.dart';
import '/value_renderer.dart';

class RadioInput extends FormField<ValueHintsDefaultValue?> {
  RadioInput({
    super.key,
    ValueRendererController? controller,
    InputDecoration? decoration,
    required String fieldName,
    super.initialValue,
    super.onSaved,
    required RenderHintsTechnicalType technicalType,
    super.validator,
    required List<ValueHintsValue> values,
  }) : super(
          builder: (FormFieldState<ValueHintsDefaultValue?> field) {
            if (field.value != null) {
              controller?.value = ControllerTypeResolver.resolveType(
                inputValue: field.value,
                type: technicalType,
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TranslatedText(fieldName),
                ...values.map(
                  (option) => InputDecorator(
                    decoration: decoration ?? const InputDecoration(border: InputBorder.none),
                    child: RadioListTile<ValueHintsDefaultValue>(
                      title: TranslatedText(option.displayName),
                      value: option.key,
                      groupValue: field.value,
                      onChanged: (ValueHintsDefaultValue? value) {
                        if (value == null) return;

                        controller?.value = ControllerTypeResolver.resolveType(
                          inputValue: value,
                          type: technicalType,
                        );
                        field.didChange(value);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
}
