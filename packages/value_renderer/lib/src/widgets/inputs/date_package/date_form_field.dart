import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:value_renderer/src/value_renderer.dart';

import './date_field.dart';

/// A [FormField] that contains a [DateTimeField].
///
/// This is a convenience widget that wraps a [DateTimeField] widget in a
/// [FormField].
///
/// A [Form] ancestor is not required. The [Form] simply makes it easier to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
class DateTimeFormField extends FormField<DateTime> {
  DateTimeFormField({
    Key? key,
    this.initialDateAttribute,
    ValueRendererController? controller,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    AttributeValue? initialValueAttribute,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
    bool use24hFormat = false,
    TextStyle? dateTextStyle,
    DateFormat? dateFormat,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    required String fieldName,
    ValueChanged<DateTime>? onDateSelected,
    InputDecoration? decoration,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    DateTimeFieldCreator fieldCreator = DateTimeField.new,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: _getInitialDateAttribute(initialValueAttribute),
          validator: validator,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          builder: (FormFieldState<DateTime> field) {
            // Theme defaults are applied inside the _InputDropdown widget
            final InputDecoration decorationWithThemeDefaults = decoration ?? const InputDecoration();

            final InputDecoration effectiveDecoration = decorationWithThemeDefaults.copyWith(errorText: field.errorText);

            void onChangedHandler(DateTime value) {
              if (onDateSelected != null) {
                onDateSelected(value);
              }
              field.didChange(value);
              controller?.value = value;
            }

            return fieldCreator(
              controller: controller,
              firstDate: firstDate,
              fieldName: fieldName,
              initialDate: _getInitialDateAttribute(initialValueAttribute),
              lastDate: lastDate,
              decoration: effectiveDecoration,
              initialDatePickerMode: initialDatePickerMode,
              dateFormat: dateFormat,
              onDateSelected: onChangedHandler,
              selectedDate: field.value,
              enabled: enabled,
              use24hFormat: use24hFormat,
              initialEntryMode: initialEntryMode,
              dateTextStyle: dateTextStyle,
            );
          },
        );

  final DateTime? initialDateAttribute;

  static DateTime? _getInitialDateAttribute(AttributeValue? initialValueAttribute) {
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
