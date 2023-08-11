import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatepickerInput extends StatefulWidget {
  final String? fieldName;
  final Map<String, dynamic>? initialValue;

  const DatepickerInput({super.key, this.fieldName, this.initialValue});

  @override
  State<DatepickerInput> createState() => _DatepickerInputState();
}

class _DatepickerInputState extends State<DatepickerInput> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      _selectedDate = DateTime(widget.initialValue!['year'], widget.initialValue!['month'], widget.initialValue!['day']);
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(1900, now.month, now.day);
    final lastDate = DateTime(2200, now.month, now.day);
    final pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: lastDate);
    if (pickedDate == null) return;

    if (mounted) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _clearDatePicker() {
    setState(() {
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //TODO: Localize hardcoded text when possible
        Text(
          widget.fieldName ?? 'Date',
        ),
        const SizedBox(
          width: 12,
        ),
        //TODO: Localize hardcoded text when possible
        Text(_selectedDate != null ? DateFormat.yMd().format(_selectedDate!) : 'No date selected'),
        IconButton(icon: const Icon(Icons.calendar_month), onPressed: _presentDatePicker),
        IconButton(icon: const Icon(Icons.clear), onPressed: _clearDatePicker)
      ],
    );
  }
}
