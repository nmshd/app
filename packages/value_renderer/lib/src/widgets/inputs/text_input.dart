import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({super.key, this.fieldName = 'Text Field', required this.initialValue});

  final String? initialValue;
  final String? fieldName;

  @override
  State<TextInput> createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController()..text = widget.initialValue!,
      decoration: InputDecoration(labelText: widget.fieldName),
    );
  }
}
