import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String? initialValue;
  final String? fieldName;
  final int? max;

  const TextInput({super.key, this.fieldName = 'Text Field', required this.initialValue, this.max});

  @override
  State<TextInput> createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.max,
      controller: TextEditingController()..text = widget.initialValue!,
      decoration: InputDecoration(labelText: widget.fieldName),
    );
  }
}
