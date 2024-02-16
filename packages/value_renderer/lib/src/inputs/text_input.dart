import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../utils/utils.dart';
import '../value_renderer_controller.dart';
import 'styles/input_decoration.dart';

class TextInput extends StatefulWidget {
  final ValueRendererController? controller;
  final InputDecoration? decoration;
  final String? fieldName;
  final ValueHintsDefaultValueString? initialValue;
  final int? max;
  final bool mustBeFilledOut;
  final String? pattern;
  final List<ValueHintsValue>? values;

  const TextInput({
    super.key,
    this.controller,
    this.decoration,
    this.fieldName,
    required this.initialValue,
    this.max,
    required this.mustBeFilledOut,
    this.pattern,
    this.values,
  });

  @override
  State<TextInput> createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  late TextEditingController _controller;
  String? _translatedText;

  @override
  void initState() {
    super.initState();

    final initialValue = widget.initialValue;
    _controller = TextEditingController(text: initialValue?.value);

    if (widget.controller != null) {
      _controller.addListener(() => widget.controller!.value = ValueRendererInputValueString(_controller.text));
      if (initialValue != null) {
        widget.controller!.value = ValueRendererInputValueString(
          widget.initialValue!.value,
        );
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
    if (widget.fieldName != null) {
      _translatedText = widget.fieldName!.startsWith('i18n://') ? FlutterI18n.translate(context, widget.fieldName!.substring(7)) : widget.fieldName!;
    }

    return Form(
      child: TextFormField(
        maxLength: widget.max,
        controller: _controller,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) => validateInput(value),
        decoration: widget.decoration != null
            ? widget.decoration!.copyWith(labelText: _translatedText)
            : inputDecoration.copyWith(labelText: _translatedText),
      ),
    );
  }

  String? validateInput(input) {
    if (input.isEmpty && widget.mustBeFilledOut) {
      return FlutterI18n.translate(context, 'errors.value_renderer.emptyField');
    } else if (input.isNotEmpty && !validateEquality(input)) {
      return FlutterI18n.translate(context, 'errors.value_renderer.invalidInput');
    } else if (input.isNotEmpty && !validateFormat(input)) {
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

    final parsedRegex = parseRegExp(widget.pattern!);

    return parsedRegex.hasMatch(input);
  }
}
