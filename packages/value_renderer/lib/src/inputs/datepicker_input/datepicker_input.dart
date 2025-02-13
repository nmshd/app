import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateTime defaultFirstDate = DateTime(1900);
final DateTime defaultLastDate = DateTime(2100);

class DatepickerInput extends StatefulWidget {
  final DateFormat dateFormat;
  final InputDecoration decoration;
  final bool enabled;
  final String? fieldName;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime?>? onDateSelected;
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
  }) : firstDate = firstDate ?? defaultFirstDate,
       lastDate = lastDate ?? defaultLastDate;

  @override
  State<DatepickerInput> createState() => _DatepickerInputState();
}

class _DatepickerInputState extends State<DatepickerInput> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();

    _selectedDate = widget.selectedDate;
    if (_selectedDate != null) _controller.text = widget.dateFormat.format(_selectedDate!);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.enabled ? _selectDate : null,
      readOnly: true,
      controller: _controller,
      decoration: widget.decoration.copyWith(
        suffixIcon: _selectedDate == null ? const Icon(Icons.calendar_today) : IconButton(onPressed: _clearDate, icon: const Icon(Icons.clear)),
      ),
    );
  }

  void _selectDate() async {
    final DateTime initialDateTime;

    if (widget.selectedDate != null) {
      initialDateTime = widget.selectedDate!;
    } else {
      final DateTime now = DateTime.now();
      if (widget.firstDate.isAfter(now) || widget.lastDate.isBefore(now)) {
        initialDateTime = widget.initialDate ?? widget.lastDate;
      } else {
        initialDateTime = widget.initialDate ?? now;
      }
    }

    final pickedDate = await showDatePicker(context: context, initialDate: initialDateTime, firstDate: widget.firstDate, lastDate: widget.lastDate);
    if (pickedDate == null) return;

    widget.onDateSelected!(pickedDate);
    _controller.text = widget.dateFormat.format(pickedDate);
    if (mounted) setState(() => _selectedDate = pickedDate);
  }

  void _clearDate() {
    widget.onDateSelected!(null);
    _controller.clear();
  }
}
