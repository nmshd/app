import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateTime defaultFirstDate = DateTime(1900);
final DateTime defaultLastDate = DateTime(2100);

class DatepickerInput extends StatelessWidget {
  final DateFormat dateFormat;
  final InputDecoration decoration;
  final bool? enabled;
  final String? fieldName;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final DateTime? selectedDate;

  DatepickerInput({
    super.key,
    required this.dateFormat,
    required this.decoration,
    this.enabled = true,
    this.fieldName,
    DateTime? firstDate,
    this.initialDate,
    DateTime? lastDate,
    required this.onDateSelected,
    required this.selectedDate,
  })  : firstDate = firstDate ?? defaultFirstDate,
        lastDate = lastDate ?? defaultLastDate;

  @override
  Widget build(BuildContext context) {
    String? text;

    if (selectedDate != null) text = dateFormat.format(selectedDate!);

    return _DecoratedDatePicker(
      text: text,
      isEmpty: selectedDate == null,
      decoration: decoration,
      onPressed: enabled! ? () => _selectDate(context) : null,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDateTime;

    if (selectedDate != null) {
      initialDateTime = selectedDate!;
    } else {
      final DateTime now = DateTime.now();
      if (firstDate.isAfter(now) || lastDate.isBefore(now)) {
        initialDateTime = initialDate ?? lastDate;
      } else {
        initialDateTime = initialDate ?? now;
      }
    }

    DateTime selectedDateTime = initialDateTime;

    final DateTime? selectedDatePicker = await showMaterialDatePicker(context, initialDateTime);

    if (selectedDatePicker != null) {
      selectedDateTime = selectedDatePicker;
    } else {
      return;
    }

    onDateSelected!(selectedDateTime);
  }

  Future<DateTime?> showMaterialDatePicker(
    BuildContext context,
    DateTime initialDateTime,
  ) {
    return showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }
}

class _DecoratedDatePicker extends StatefulWidget {
  final InputDecoration decoration;
  final bool isEmpty;
  final VoidCallback? onPressed;
  final String? text;

  const _DecoratedDatePicker({
    required this.decoration,
    required this.text,
    required this.isEmpty,
    this.onPressed,
  });

  @override
  State<_DecoratedDatePicker> createState() => _DecoratedDatePickerState();
}

class _DecoratedDatePickerState extends State<_DecoratedDatePicker> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Focus(
          onFocusChange: (bool newFocus) => setState(() {
            focused = newFocus;
          }),
          child: InputDecorator(
            isHovering: focused,
            isEmpty: widget.isEmpty,
            decoration: widget.decoration.applyDefaults(Theme.of(context).inputDecorationTheme),
            child: widget.text != null
                ? Text(widget.text!, style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.normal))
                : const Text(''),
          ),
        ),
      ),
    );
  }
}
