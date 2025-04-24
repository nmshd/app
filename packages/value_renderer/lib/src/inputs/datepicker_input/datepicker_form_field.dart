import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../utils/utils.dart';
import '../../value_renderer_controller.dart';
import '../extensions.dart';
import '../styles/input_decoration.dart';
import 'datepicker_input.dart';

class DatepickerFormField extends FormField<DateTime> {
  DatepickerFormField({
    super.key,
    ValueRendererController? controller,
    required DateFormat dateFormat,
    InputDecoration? decoration,
    required bool mustBeFilledOut,
    super.enabled,
    String? fieldName,
    DateTime? firstDate,
    DateTime? initialDate,
    AttributeValue? initialValueAttribute,
    DateTime? lastDate,
    ValueChanged<DateTime?>? onDateSelected,
    String? emptyFieldMessage,
    super.onSaved,
  }) : super(
         initialValue: getInitialDateAttribute(initialValueAttribute),
         validator: (value) => value == null && mustBeFilledOut ? emptyFieldMessage : null,
         builder: (FormFieldState<DateTime> field) {
           if (field.value != null) controller?.value = ValueRendererInputValueDateTime(field.value!);

           void onChangedHandler(DateTime? value) {
             onDateSelected?.call(value);
             field.didChange(value);
             controller?.value = value != null ? ValueRendererInputValueDateTime(value) : null;
           }

           return Builder(
             builder:
                 (context) => DatepickerInput(
                   dateFormat: dateFormat,
                   enabled: enabled,
                   firstDate: firstDate,
                   fieldName: context.translateFieldName(fieldName, mustBeFilledOut),
                   initialDate: getInitialDateAttribute(initialValueAttribute),
                   lastDate: lastDate,
                   onDateSelected: onChangedHandler,
                   selectedDate: field.value,
                   decoration: (decoration ?? inputDecoration(context)).copyWith(
                     labelText: context.translateFieldName(fieldName, mustBeFilledOut),
                     errorText: field.errorText,
                     suffixIcon: const Icon(Icons.calendar_month),
                     floatingLabelBehavior: FloatingLabelBehavior.auto,
                   ),
                 ),
           );
         },
       );

  static DateTime? getInitialDateAttribute(AttributeValue? initialValueAttribute) {
    switch (initialValueAttribute) {
      case null:
        return null;
      case final BirthDateAttributeValue value:
        return DateTime(value.year, value.month, value.day);
      default:
        GetIt.I.get<Logger>().e('Cannot assign defult value of ${initialValueAttribute.runtimeType} in the DatePicker.');
        return null;
    }
  }

  @override
  FormFieldState<DateTime> createState() => FormFieldState<DateTime>();
}
