import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:translated_text/translated_text.dart';

import '../utils/utils.dart';
import '/value_renderer.dart';

class SegmentedButtonInput extends FormField<ValueHintsDefaultValue?> {
  SegmentedButtonInput({
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
            final translatedText = fieldName.startsWith('i18n://') ? FlutterI18n.translate(field.context, fieldName.substring(7)) : fieldName;
            if (field.value != null) {
              controller?.value = ControllerTypeResolver.resolveType(
                inputValue: field.value,
                type: technicalType,
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.only(left: 16), child: Text(translatedText)),
                InputDecorator(
                  decoration: decoration ?? const InputDecoration(border: InputBorder.none),
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
