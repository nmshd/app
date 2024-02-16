import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateTime defaultFirstDate = DateTime(1900);
final DateTime defaultLastDate = DateTime(2100);

class DatepickerInput extends StatelessWidget {
  DatepickerInput({
    super.key,
    DateFormat? dateFormat,
    this.dateTextStyle,
    this.decoration,
    this.enabled = true,
    required this.fieldName,
    DateTime? firstDate,
    this.initialDate,
    DateTime? lastDate,
    required this.onDateSelected,
    required this.selectedDate,
  })  : dateFormat = DateFormat.yMd(),
        firstDate = firstDate ?? defaultFirstDate,
        lastDate = lastDate ?? defaultLastDate;

  final DateFormat dateFormat;
  final TextStyle? dateTextStyle;
  final InputDecoration? decoration;
  final bool? enabled;
  final String fieldName;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final DateTime? selectedDate;

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

  @override
  Widget build(BuildContext context) {
    String? text;

    if (selectedDate != null) text = dateFormat.format(selectedDate!);

    TextStyle? textStyle;

    textStyle = dateTextStyle ?? dateTextStyle;

    return _InputDropdown(
      text: text,
      textStyle: textStyle,
      isEmpty: selectedDate == null,
      decoration: decoration,
      onPressed: enabled! ? () => _selectDate(context) : null,
    );
  }
}

class _InputDropdown extends StatefulWidget {
  const _InputDropdown({
    this.decoration,
    required this.text,
    required this.isEmpty,
    this.onPressed,
    this.textStyle,
  });

  final InputDecoration? decoration;
  final bool isEmpty;
  final VoidCallback? onPressed;
  final String? text;
  final TextStyle? textStyle;

  @override
  State<_InputDropdown> createState() => _InputDropdownState();
}

class _InputDropdownState extends State<_InputDropdown> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    final InputDecoration effectiveDecoration = widget.decoration ??
        const InputDecoration(
          suffixIcon: Icon(Icons.arrow_drop_down),
        );

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
            decoration: effectiveDecoration.applyDefaults(
              Theme.of(context).inputDecorationTheme,
            ),
            child: widget.text == null ? Text('', style: widget.textStyle) : Text(widget.text!, style: widget.textStyle),
          ),
        ),
      ),
    );
  }
}
