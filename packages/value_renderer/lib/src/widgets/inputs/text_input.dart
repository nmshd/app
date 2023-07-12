import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({super.key, this.fieldName = 'Text Fieldz'});

  final String? fieldName;

  @override
  State<TextInput> createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: widget.fieldName),
    );
  }
}
