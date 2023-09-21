import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/value_renderer.dart';
import '../utils/utils.dart';

class RadioInput extends FormField<ValueHintsDefaultValue?> {
  RadioInput({
    Key? key,
    ValueRendererController? controller,
    required String fieldName,
    ValueHintsDefaultValue? initialValue,
    FormFieldSetter<ValueHintsDefaultValue?>? onSaved,
    required RenderHintsTechnicalType technicalType,
    FormFieldValidator<ValueHintsDefaultValue?>? validator,
    required List<ValueHintsValue> values,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<ValueHintsDefaultValue?> field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TranslatedText(fieldName),
                ...values.map(
                  (option) => RadioListTile<ValueHintsDefaultValue>(
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
              ],
            );
          },
        );
}
