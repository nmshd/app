import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '/value_renderer.dart';
import '../utils/utils.dart';

class RadioInput extends FormField<ValueHintsDefaultValue?> {
  RadioInput({
    Key? key,
    ValueRendererController? controller,
    InputDecoration? decoration,
    required String fieldName,
    ValueHintsDefaultValue? initialValue,
    FormFieldSetter<ValueHintsDefaultValue?>? onSaved,
    required RenderHintsTechnicalType technicalType,
    FormFieldValidator<ValueHintsDefaultValue?>? validator,
    required List<ValueHintsValue> values,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (FormFieldState<ValueHintsDefaultValue?> field) {
            controller?.value = field.value;
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
