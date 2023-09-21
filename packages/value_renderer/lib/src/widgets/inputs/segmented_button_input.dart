import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/value_renderer.dart';
import '../utils/utils.dart';

class SegmentedButtonInput extends FormField<ValueHintsDefaultValue?> {
  SegmentedButtonInput({
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
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 18, 0, 12),
                  child: TranslatedText(fieldName),
                ),
                SegmentedButton<ValueHintsDefaultValue>(
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
              ],
            );
          },
        );
}
