import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
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
    final bool? mustBeAccepted,
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
                TranslatedText(
                  fieldName,
                  style: field.value != null ? null : const TextStyle(color: Color(0xFFb3261e)),
                ),
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
                if (field.value == null && mustBeAccepted == null)
                  Text(
                    FlutterI18n.translate(
                      field.context,
                      'errors.value_renderer.emptyField',
                    ),
                    style: const TextStyle(color: Color(0xFFb3261e), fontSize: 12),
                  )
              ],
            );
          },
        );
}
