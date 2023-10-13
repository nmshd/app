import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:translated_text/translated_text.dart';

import '/value_renderer.dart';
import '../utils/utils.dart';

class SegmentedButtonInput extends FormField<ValueHintsDefaultValue?> {
  SegmentedButtonInput({
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
            final BuildContext context = field.context;
            final translatedText = fieldName.startsWith('i18n://') ? FlutterI18n.translate(context, fieldName.substring(7)) : fieldName;
            controller?.value = field.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputDecorator(
                  decoration: decoration != null
                      ? decoration.copyWith(labelText: translatedText)
                      : InputDecoration(border: InputBorder.none, labelText: translatedText),
                  child: SegmentedButton<ValueHintsDefaultValue>(
                    selected: field.value == null ? {} : {field.value!},
                    segments: values.map((ValueHintsValue value) {
                      return ButtonSegment<ValueHintsDefaultValue>(
                        value: value.key,
                        label: TranslatedText(value.displayName),
                      );
                    }).toList(),
                    onSelectionChanged: (Set<ValueHintsDefaultValue> newSelection) {
                      controller?.value = ControllerTypeResolver.resolveType(inputValue: newSelection.first, type: technicalType);
                      field.didChange(newSelection.first);
                    },
                  ),
                ),
              ],
            );
          },
        );
}
