import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class DatepickerButton extends StatefulWidget {
  const DatepickerButton({super.key, this.fieldName, this.initialValue});

  final String? fieldName;
  final Map<String, dynamic>? initialValue;

  @override
  State<DatepickerButton> createState() => _DatepickerButtonState();
}

class _DatepickerButtonState extends State<DatepickerButton> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // ignore: prefer_is_not_empty
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      _selectedDate = DateTime(widget.initialValue!['year'], widget.initialValue!['month'], widget.initialValue!['day']);
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);

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
        Text(
          widget.fieldName ?? 'Date',
        ),
        const SizedBox(
          width: 12,
        ),
        Text(_selectedDate != null ? formatter.format(_selectedDate!) : 'No date selected'),
        IconButton(onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month))
      ],
    );
  }
}
