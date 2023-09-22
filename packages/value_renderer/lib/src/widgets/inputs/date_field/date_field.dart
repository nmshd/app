import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final DateTime defaultFirstDate = DateTime(1900);
final DateTime defaultLastDate = DateTime(2100);

class DatepickerInput extends StatelessWidget {
  DatepickerInput({
    Key? key,
    required this.onDateSelected,
    required this.selectedDate,
    this.decoration,
    this.enabled = true,
    this.dateTextStyle,
    this.initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    DateFormat? dateFormat,
    required this.fieldName,
  })  : dateFormat = DateFormat.yMMMMd(),
        firstDate = firstDate ?? defaultFirstDate,
        lastDate = lastDate ?? defaultLastDate,
        super(key: key);

  final ValueChanged<DateTime>? onDateSelected;
  final String fieldName;
  final DateTime? selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  final InputDecoration? decoration;
  final DateFormat dateFormat;
  final bool? enabled;
  final TextStyle? dateTextStyle;

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
    Key? key,
    required this.text,
    this.decoration,
    this.textStyle,
    this.onPressed,
    required this.isEmpty,
  }) : super(key: key);

  final String? text;
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final bool isEmpty;

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
          onKey: (_, RawKeyEvent key) {
            if (key.isKeyPressed(LogicalKeyboardKey.space)) {
              widget.onPressed?.call();
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InputDecorator(
            isHovering: focused,
            decoration: effectiveDecoration.applyDefaults(
              Theme.of(context).inputDecorationTheme,
            ),
            isEmpty: widget.isEmpty,
            child: widget.text == null ? Text('', style: widget.textStyle) : Text(widget.text!, style: widget.textStyle),
          ),
        ),
      ),
    );
  }
}
