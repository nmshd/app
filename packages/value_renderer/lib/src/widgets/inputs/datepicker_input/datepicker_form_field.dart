import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './datepicker_input.dart';
import '/value_renderer.dart';

class DatepickerFormField extends FormField<DateTime> {
  DatepickerFormField({
    super.key,
    super.autovalidateMode,
    ValueRendererController? controller,
    TextStyle? dateTextStyle,
    DateFormat? dateFormat,
    InputDecoration? decoration,
    super.enabled,
    required String fieldName,
    DateTime? firstDate,
    DateTime? initialDate,
    AttributeValue? initialValueAttribute,
    DateTime? lastDate,
    ValueChanged<DateTime>? onDateSelected,
    super.onSaved,
    super.validator,
  }) : super(
          initialValue: getInitialDateAttribute(initialValueAttribute),
          builder: (FormFieldState<DateTime> field) {
            final InputDecoration decorationWithThemeDefaults = decoration ?? const InputDecoration();

            final InputDecoration effectiveDecoration = decorationWithThemeDefaults.copyWith(errorText: field.errorText);

            controller?.value = field.value;

            void onChangedHandler(DateTime value) {
              if (onDateSelected != null) {
                onDateSelected(value);
              }
              field.didChange(value);
              controller?.value = value;
            }

            return DatepickerInput(
              dateFormat: dateFormat,
              dateTextStyle: dateTextStyle,
              decoration: effectiveDecoration,
              enabled: enabled,
              firstDate: firstDate,
              fieldName: fieldName,
              initialDate: getInitialDateAttribute(initialValueAttribute),
              lastDate: lastDate,
              onDateSelected: onChangedHandler,
              selectedDate: field.value,
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
        logCannotHandle(initialValueAttribute);
        return null;
    }
  }

  static void logCannotHandle(AttributeValue attributeValue) {
    // TODO add a proper logger
    // ignore: avoid_print
    print('Cannot assign defult value of ${attributeValue.runtimeType} in the DatePicker.');
    return;
  }

  @override
  FormFieldState<DateTime> createState() => FormFieldState<DateTime>();
}
