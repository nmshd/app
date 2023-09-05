import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../value_renderer.dart';

class TextInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String fieldName;
  final String? initialValue;
  final int? max;
  final String? pattern;
  final List<ValueHintsValue>? values;

  const TextInput({
    super.key,
    this.controller,
    required this.fieldName,
    required this.initialValue,
    this.max,
    this.pattern,
    this.values,
  });

  @override
  State<TextInput> createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    final initialValue = widget.initialValue;
    _controller = TextEditingController(text: initialValue);

    if (widget.controller != null) {
      _controller.addListener(() => widget.controller!.value = _controller.text);
      if (initialValue != null) widget.controller!.value = initialValue;
    }
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

    return Form(
      child: TextFormField(
        maxLength: widget.max,
        controller: _controller,
        decoration: InputDecoration(labelText: translatedText),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => validateInput(value),
      ),
    );
  }

  String? validateInput(input) {
    if (input.isEmpty) {
      return FlutterI18n.translate(context, 'errors.value_renderer.emptyField');
    } else if (!validateEquality(input)) {
      return FlutterI18n.translate(context, 'errors.value_renderer.invalidInput');
    } else if (!validateFormat(input)) {
      return FlutterI18n.translate(context, 'errors.value_renderer.invalidFormat');
    }
    return null;
  }

  bool validateEquality(String input) {
    if (widget.values == null) return true;

    return widget.values!.map((e) => e.key).contains(ValueHintsDefaultValueString(input));
  }

  bool validateFormat(String input) {
    if (widget.pattern == null) return true;

    final valuePattern = RegExp(widget.pattern!);
    return valuePattern.hasMatch(input);
  }
}
