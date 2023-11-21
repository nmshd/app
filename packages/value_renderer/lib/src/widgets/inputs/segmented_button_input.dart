import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
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
            controller?.value = field.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 18, 0, 12),
                  child: TranslatedText(fieldName),
                ),
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
                      controller?.value = ControllerTypeResolver.resolveType(
                        inputValue: newSelection.first,
                        type: technicalType,
                      );

                      field.didChange(newSelection.first);
                    },
                  ),
                ),
              ],
            );
          },
        );
}
