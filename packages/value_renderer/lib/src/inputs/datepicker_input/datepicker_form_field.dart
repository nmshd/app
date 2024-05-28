import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../utils/utils.dart';
import '../../value_renderer_controller.dart';
import '../extensions.dart';
import '../styles/input_decoration.dart';
import './datepicker_input.dart';

final DateTime defaultFirstDate = DateTime(1900);
final DateTime defaultLastDate = DateTime(2100);

class DatepickerFormField extends FormField<DateTime> {
  DatepickerFormField({
    super.key,
    super.enabled,
    ValueRendererController? controller,
    required DateFormat dateFormat,
    InputDecoration? decoration,
    required bool mustBeFilledOut,
    String? fieldName,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    AttributeValue? initialValueAttribute,
    ValueChanged<DateTime?>? onDateSelected,
    String? emptyFieldMessage,
    super.onSaved,
  }) : super(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => value == null && mustBeFilledOut ? emptyFieldMessage : null,
          initialValue: getInitialDate(
            initialDate: getInitialDateAttributeValue(initialValueAttribute) ?? initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
          ),
          builder: (FormFieldState<DateTime> field) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (field.value != null) controller?.value = ValueRendererInputValueDateTime(field.value!);
            });

            void onChangedHandler(DateTime? value) {
              onDateSelected?.call(value);
              field.didChange(value);
              controller?.value = value != null ? ValueRendererInputValueDateTime(value) : null;
            }

            return Builder(
              builder: (context) => DatepickerInput(
                dateFormat: dateFormat,
                enabled: enabled,
                firstDate: firstDate ?? defaultFirstDate,
                fieldName: context.translateFieldName(fieldName, mustBeFilledOut),
                lastDate: lastDate ?? defaultLastDate,
                onDateSelected: onChangedHandler,
                selectedDate: field.value,
                initialDate: getInitialDate(
                  initialDate: getInitialDateAttributeValue(initialValueAttribute) ?? initialDate,
                  firstDate: firstDate,
                  lastDate: lastDate,
                ),
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

  static DateTime? getInitialDate({DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) {
    if (initialDate != null) {
      final firstDateValue = firstDate ?? defaultFirstDate;
      final lastDateValue = lastDate ?? defaultLastDate;

      if (initialDate.isBefore(firstDateValue) || initialDate.isAfter(lastDateValue)) {
        return firstDateValue;
      }
    }
    return initialDate;
  }

  static DateTime? getInitialDateAttributeValue(AttributeValue? initialValueAttribute) {
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
