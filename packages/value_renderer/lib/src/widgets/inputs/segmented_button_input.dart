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
              children: [
                TranslatedText(
                  fieldName,
                  style: field.value == null && mustBeAccepted == true ? const TextStyle(color: Color(0xFFb3261e)) : null,
                ),
                InputDecorator(
                  decoration: decoration ?? const InputDecoration(border: InputBorder.none),
                  child: SegmentedButton<ValueHintsDefaultValue>(
                    emptySelectionAllowed: true,
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
                if (field.value == null && mustBeAccepted == true)
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
