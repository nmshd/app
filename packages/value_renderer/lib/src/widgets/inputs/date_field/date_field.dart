import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:value_renderer/src/value_renderer.dart';

final DateTime _kDefaultFirstSelectableDate = DateTime(1900);
final DateTime _kDefaultLastSelectableDate = DateTime(2100);

const double kCupertinoDatePickerHeight = 216;

/// Constructor tearoff definition that matches [DateTimeField.new]
// Note: This should match the definition of the [DateTimeField] constructor
typedef DateTimeFieldCreator = DateTimeField Function({
  Key? key,
  ValueRendererController? controller,
  required String fieldName,
  required ValueChanged<DateTime>? onDateSelected,
  required DateTime? selectedDate,
  DateFormat? dateFormat,
  TextStyle? dateTextStyle,
  InputDecoration? decoration,
  bool? enabled,
  DateTime? firstDate,
  DateTime? initialDate,
  DatePickerMode? initialDatePickerMode,
  DatePickerEntryMode initialEntryMode,
  DateTime? lastDate,
  bool use24hFormat,
  TimePickerEntryMode initialTimePickerEntryMode,
});

/// [DateTimeField]
///
/// Shows an [_InputDropdown] that'll trigger [DateTimeField._selectDate] whenever the user
/// clicks on it ! The date picker is **platform responsive** (ios date picker style for ios, ...)
class DateTimeField extends StatelessWidget {
  // Note: This should match the definition of the [DateTimeFieldCreator]
  DateTimeField({
    Key? key,
    required this.onDateSelected,
    required this.selectedDate,
    this.initialDatePickerMode = DatePickerMode.day,
    this.decoration,
    this.enabled = true,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.dateTextStyle,
    this.initialDate,
    this.use24hFormat = false,
    DateTime? firstDate,
    DateTime? lastDate,
    DateFormat? dateFormat,
    this.initialTimePickerEntryMode = TimePickerEntryMode.dial,
    this.controller,
    required this.fieldName,
  })  : dateFormat = DateFormat.yMMMMd(),
        firstDate = firstDate ?? _kDefaultFirstSelectableDate,
        lastDate = lastDate ?? _kDefaultLastSelectableDate,
        super(key: key);

  /// Callback for whenever the user selects a [DateTime]
  final ValueChanged<DateTime>? onDateSelected;
  final ValueRendererController? controller;
  final String fieldName;

  final DateTime? selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;

  /// Let you choose the [DatePickerMode] for the date picker! (default is [DatePickerMode.day]
  final DatePickerMode? initialDatePickerMode;

  /// Custom [InputDecoration] for the [InputDecorator] widget
  final InputDecoration? decoration;

  /// How to display the [DateTime] for the user (default is [DateFormat.yMMMD])
  final DateFormat dateFormat;

  final bool? enabled;
  final bool use24hFormat;

  /// [TextStyle] of the selected date inside the field.
  final TextStyle? dateTextStyle;

  /// The initial entry mode for the material date picker dialog
  final DatePickerEntryMode initialEntryMode;

  // the initial entry mode for the material time picker dialog
  final TimePickerEntryMode initialTimePickerEntryMode;

  /// Shows a dialog asking the user to pick a date !
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

  /// Launches the Material time picker by invoking [showDatePicker].
  /// Can be @[override]n to allow further customization of the picker options
  Future<DateTime?> showMaterialDatePicker(
    BuildContext context,
    DateTime initialDateTime,
  ) {
    return showDatePicker(
      context: context,
      initialDatePickerMode: initialDatePickerMode!,
      initialDate: initialDateTime,
      initialEntryMode: initialEntryMode,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    String? text;

    if (selectedDate != null) {
      text = dateFormat.format(selectedDate!);
    }
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

///
/// [_InputDropdown]
///
/// Shows a field with a dropdown arrow !
/// It does not show any popup menu, it'll just trigger onPressed whenever the
/// user does click on it !
class _InputDropdown extends StatefulWidget {
  const _InputDropdown({
    Key? key,
    required this.text,
    this.decoration,
    this.textStyle,
    this.onPressed,
    required this.isEmpty,
  }) : super(key: key);

  /// The text that should be displayed inside the field
  final String? text;

  /// Custom [InputDecoration] for the [InputDecorator] widget
  final InputDecoration? decoration;

  /// TextStyle for the field
  final TextStyle? textStyle;

  /// Callbacks triggered whenever the user presses on the field!
  final VoidCallback? onPressed;

  /// Whether the input field is empty.
  ///
  /// Determines the position of the label text and whether to display the hint
  /// text.
  ///
  /// Defaults to false.
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
