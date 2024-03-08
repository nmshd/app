import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../utils/utils.dart';
import '../../value_renderer_controller.dart';
import '../styles/input_decoration.dart';
import './datepicker_input.dart';

class DatepickerFormField extends FormField<DateTime> {
  DatepickerFormField({
    super.key,
    ValueRendererController? controller,
    TextStyle? dateTextStyle,
    required DateFormat dateFormat,
    InputDecoration? decoration,
    required bool mustBeFilledOut,
    super.enabled,
    String? fieldName,
    DateTime? firstDate,
    DateTime? initialDate,
    AttributeValue? initialValueAttribute,
    DateTime? lastDate,
    ValueChanged<DateTime>? onDateSelected,
    String? emptyFieldMessage,
    super.onSaved,
  }) : super(
          initialValue: getInitialDateAttribute(initialValueAttribute),
          autovalidateMode: AutovalidateMode.always,
          validator: (value) => value == null && mustBeFilledOut ? emptyFieldMessage : null,
          builder: (FormFieldState<DateTime> field) {
            if (field.value != null) controller?.value = ValueRendererInputValueDateTime(field.value!);

            void onChangedHandler(DateTime value) {
              if (onDateSelected != null) {
                onDateSelected(value);
              }
              field.didChange(value);
              controller?.value = ValueRendererInputValueDateTime(field.value!);
            }

            return DatepickerInput(
              dateFormat: dateFormat,
              dateTextStyle: dateTextStyle,
              enabled: enabled,
              firstDate: firstDate,
              fieldName: fieldName,
              initialDate: getInitialDateAttribute(initialValueAttribute),
              lastDate: lastDate,
              onDateSelected: onChangedHandler,
              selectedDate: field.value,
              decoration: decoration != null
                  ? decoration.copyWith(labelText: fieldName, errorText: field.errorText)
                  : inputDecoration.copyWith(labelText: fieldName, errorText: field.errorText, suffixIcon: const Icon(Icons.calendar_today)),
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
