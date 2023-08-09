import 'package:flutter/material.dart';

class NumberInput extends StatefulWidget {
  final String? initialValue;
  final String? fieldName;
  final double max;

  const NumberInput({super.key, this.fieldName = 'Number Field', required this.initialValue, required this.max});

  @override
  State<NumberInput> createState() => NumberInputState();
}

class NumberInputState extends State<NumberInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.max.toInt(),
      controller: TextEditingController()..text = widget.initialValue.toString(),
      decoration: InputDecoration(labelText: widget.fieldName),
      keyboardType: TextInputType.number,
    );
  }
}
