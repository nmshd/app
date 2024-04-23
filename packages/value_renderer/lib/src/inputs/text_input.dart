import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../value_renderer.dart';
import '../utils/utils.dart';
import 'styles/input_decoration.dart';

class TextInput extends StatefulWidget {
  final bool mustBeFilledOut;
  final AutovalidateMode autovalidateMode;
  final ValueRendererController? controller;
  final InputDecoration? decoration;
  final String? fieldName;
  final ValueHintsDefaultValueString? initialValue;
  final int? max;
  final String? pattern;
  final Map<String, String>? formatValidations;
  final List<ValueHintsValue>? values;
  final Function(String)? onChanged;

  const TextInput({
    required this.mustBeFilledOut,
    this.autovalidateMode = AutovalidateMode.always,
    this.controller,
    this.decoration,
    this.fieldName,
    this.initialValue,
    this.max,
    this.pattern,
    this.values,
    this.onChanged,
    this.formatValidations,
    super.key,
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
    _controller = TextEditingController(text: initialValue?.value);

    if (widget.controller != null) {
      _controller.addListener(() => widget.controller!.value =
          validateInput(_controller.text) == null ? ValueRendererInputValueString(_controller.text) : ValueRendererValidationError());
      if (initialValue != null) {
        widget.controller!.value = ValueRendererInputValueString(widget.initialValue!.value);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? translatedText;

    if (widget.fieldName != null) {
      translatedText = widget.fieldName!.startsWith('i18n://') ? FlutterI18n.translate(context, widget.fieldName!.substring(7)) : widget.fieldName!;
    }

    return TextFormField(
      onChanged: widget.onChanged,
      maxLength: widget.max,
      controller: _controller,
      autovalidateMode: widget.autovalidateMode,
      validator: (value) => validateInput(value),
      decoration: widget.decoration != null
          ? widget.decoration!.copyWith(labelText: translatedText)
          : inputDecoration(context).copyWith(labelText: translatedText),
    );
  }

  String? validateInput(input) {
    if (input.isEmpty && widget.mustBeFilledOut) {
      return FlutterI18n.translate(context, 'errors.value_renderer.emptyField');
    } else if (input.isNotEmpty && !validateEquality(input)) {
      return FlutterI18n.translate(context, 'errors.value_renderer.invalidInput');
    } else if (input.isNotEmpty && widget.formatValidations != null) {
      for (final entry in widget.formatValidations!.entries) {
        if (!validateFormat(input, entry.key)) {
          return FlutterI18n.translate(context, entry.value);
        }
      }
    } else if (input.isNotEmpty && !validateFormat(input, widget.pattern)) {
      return FlutterI18n.translate(context, 'errors.value_renderer.invalidFormat');
    }
    return null;
  }

  bool validateEquality(String input) {
    if (widget.values == null) return true;

    return widget.values!.map((e) => e.key).contains(ValueHintsDefaultValueString(input));
  }

  bool validateFormat(String input, String? pattern) {
    if (pattern == null) return true;

    final parsedRegex = parseRegExp(pattern);
    print(parsedRegex);

    return parsedRegex.hasMatch(input);
  }
}
