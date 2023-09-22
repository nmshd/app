import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:value_renderer/src/widgets/inputs/datepicker_input/datepicker_input.dart';

import '/value_renderer.dart';

class DatepickerFormField extends FormField<DateTime> {
  DatepickerFormField({
    Key? key,
    ValueRendererController? controller,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    AttributeValue? initialValueAttribute,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
    TextStyle? dateTextStyle,
    DateFormat? dateFormat,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    required String fieldName,
    ValueChanged<DateTime>? onDateSelected,
    InputDecoration? decoration,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: getInitialDateAttribute(initialValueAttribute),
          validator: validator,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
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
              firstDate: firstDate,
              fieldName: fieldName,
              initialDate: getInitialDateAttribute(initialValueAttribute),
              lastDate: lastDate,
              decoration: effectiveDecoration,
              dateFormat: dateFormat,
              onDateSelected: onChangedHandler,
              selectedDate: field.value,
              enabled: enabled,
              dateTextStyle: dateTextStyle,
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
