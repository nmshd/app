import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class DatepickerButton extends StatefulWidget {
  const DatepickerButton({super.key});

  @override
  State<DatepickerButton> createState() => _DatepickerButtonState();
}

class _DatepickerButtonState extends State<DatepickerButton> {
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_selectedDate != null
            ? formatter.format(_selectedDate!)
            : 'No date selected'),
        IconButton(
            onPressed: _presentDatePicker,
            icon: const Icon(Icons.calendar_month))
      ],
    );
  }
}