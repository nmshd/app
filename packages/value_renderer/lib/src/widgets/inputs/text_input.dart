import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class TextInput extends StatefulWidget {
  final String fieldName;
  final String? initialValue;
  final int? max;
  final List<ValueHintsValue>? values;

  const TextInput({
    super.key,
    required this.fieldName,
    required this.initialValue,
    this.max,
    this.values,
  });

  @override
  State<TextInput> createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  late TextEditingController _controller;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fieldName = widget.fieldName;
    final translatedText = fieldName.startsWith('i18n://') ? FlutterI18n.translate(context, fieldName.substring(7)) : fieldName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          maxLength: widget.max,
          controller: _controller,
          decoration: InputDecoration(labelText: translatedText),
          onChanged: (value) => validateInput(),
        ),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 12),
            child: Text(errorMessage!, style: const TextStyle(color: Colors.red)),
          ),
      ],
    );
  }

  void validateInput() {
    setState(() {
      if (_controller.text.isEmpty) {
        errorMessage = FlutterI18n.translate(context, 'errors.value_renderer.emptyField');
      } else if (!validateEquality(_controller.text)) {
        errorMessage = FlutterI18n.translate(context, 'errors.value_renderer.invalidInput');
      } else {
        errorMessage = null;
      }
    });
  }

  bool validateEquality(String input) {
    if (widget.values == null) return true;
    return widget.values!.map((e) => e.key).contains(ValueHintsDefaultValueString(input));
  }
}
