import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import '../../value_renderer.dart';
import '../translated_text.dart';

class DatepickerInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String fieldName;
  final AttributeValue? initialValue;

  const DatepickerInput({
    super.key,
    this.controller,
    required this.fieldName,
    this.initialValue,
  });

  @override
  State<DatepickerInput> createState() => _DatepickerInputState();
}

class _DatepickerInputState extends State<DatepickerInput> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _selectedDate = switch (widget.initialValue) {
      null => null,
      final BirthDateAttributeValue value => DateTime(value.year, value.month, value.day),
      // ....
      final AttributeValue value => logCannotHandle(value),
    };

    widget.controller?.value = _selectedDate;
  }

  logCannotHandle(AttributeValue attributeValue) {
    // TODO add a proper logger
    // ignore: avoid_print
    print('Cannot assign defult value of ${attributeValue.runtimeType} in the DatePicker.');
    return null;
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime.fromMillisecondsSinceEpoch(0);
    final lastDate = DateTime(3000, now.month, now.day);
    final pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: lastDate);
    if (pickedDate == null) return;

    if (mounted) {
      widget.controller?.value = pickedDate;

      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _clearDatePicker() {
    widget.controller?.value = null;

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
        TranslatedText(
          widget.fieldName,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
            _selectedDate != null ? DateFormat.yMd().format(_selectedDate!) : FlutterI18n.translate(context, 'errors.value_renderer.noDateSelected')),
        IconButton(icon: const Icon(Icons.calendar_month), onPressed: _presentDatePicker),
        IconButton(icon: const Icon(Icons.clear), onPressed: _clearDatePicker)
      ],
    );
  }
}
