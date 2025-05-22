import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '../utils/utils.dart';
import '../value_renderer_controller.dart';
import 'extensions.dart';

class SegmentedButtonInput extends FormField<ValueHintsDefaultValue?> {
  SegmentedButtonInput({
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
             controller?.value = ControllerTypeResolver.resolveType(inputValue: field.value, type: technicalType);
           }

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               if (fieldName != null)
                 Text(
                   field.context.translateFieldName(fieldName, mustBeFilledOut)!,
                   style: field.value == null && mustBeFilledOut ? TextStyle(color: errorColor) : null,
                 ),
               InputDecorator(
                 decoration: decoration ?? const InputDecoration(border: InputBorder.none),
                 child: SegmentedButton<ValueHintsDefaultValue>(
                   emptySelectionAllowed: true,
                   selected: field.value == null ? {} : {field.value!},
                   segments: values.map((ValueHintsValue value) {
                     return ButtonSegment<ValueHintsDefaultValue>(value: value.key, label: TranslatedText(value.displayName));
                   }).toList(),
                   onSelectionChanged: (Set<ValueHintsDefaultValue> newSelection) {
                     controller?.value = ControllerTypeResolver.resolveType(inputValue: newSelection.first, type: technicalType);
                     field.didChange(newSelection.first);
                   },
                 ),
               ),
               if (field.value == null && mustBeFilledOut)
                 Text(FlutterI18n.translate(field.context, 'errors.value_renderer.emptyField'), style: TextStyle(color: errorColor, fontSize: 12)),
             ],
           );
         },
       );
}
