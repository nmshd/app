import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class NumberInput extends StatefulWidget {
  final String? initialValue;
  final String fieldName;
  final double max;
  final List<ValueHintsValue>? values;

  const NumberInput({super.key, required this.fieldName, required this.initialValue, required this.max, this.values});

  @override
  State<NumberInput> createState() => NumberInputState();
}

class NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.max.toInt(),
      controller: _controller,
      decoration: InputDecoration(labelText: widget.fieldName),
      keyboardType: TextInputType.number,
    );
  }
}
