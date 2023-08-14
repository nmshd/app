import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String? initialValue;
  final String fieldName;
  final int? max;
  final List<ValueHintsValue>? values;

  const TextInput({super.key, required this.fieldName, required this.initialValue, this.max, this.values});

  @override
  State<TextInput> createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
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
      maxLength: widget.max,
      controller: _controller,
      decoration: InputDecoration(labelText: widget.fieldName),
    );
  }
}
