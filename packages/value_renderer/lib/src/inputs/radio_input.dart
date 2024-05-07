import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '../utils/utils.dart';
import '../value_renderer_controller.dart';
import './extensions.dart';

class RadioInput extends FormField<ValueHintsDefaultValue?> {
  RadioInput({
    super.key,
    ValueRendererController? controller,
    InputDecoration? decoration,
    String? fieldName,
    super.initialValue,
    required bool mustBeFilledOut,
    super.onSaved,
    required RenderHintsTechnicalType technicalType,
    super.validator,
    required List<ValueHintsValue> values,
    required Color errorColor,
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
                if (fieldName != null)
                  Text(
                    field.context.translateFieldName(fieldName, mustBeFilledOut)!,
                    style: field.value == null && mustBeFilledOut ? TextStyle(color: errorColor) : null,
                  ),
                ...values.map(
                  (option) => InputDecorator(
                    decoration: decoration?.copyWith(border: InputBorder.none, contentPadding: EdgeInsets.zero) ??
                        const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
                    child: RadioListTile<ValueHintsDefaultValue>(
                      contentPadding: EdgeInsets.zero,
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
                if (field.value == null && mustBeFilledOut)
                  Text(
                    FlutterI18n.translate(
                      field.context,
                      'errors.value_renderer.emptyField',
                    ),
                    style: TextStyle(color: errorColor, fontSize: 12),
                  )
              ],
            );
          },
        );
}
