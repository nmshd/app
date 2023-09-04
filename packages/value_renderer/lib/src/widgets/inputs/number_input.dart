import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../value_renderer.dart';

class NumberInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String fieldName;
  final num? initialValue;
  final num? max;
  final num? min;
  final String? pattern;
  final List<ValueHintsValue>? values;

  const NumberInput({
    super.key,
    this.controller,
    required this.fieldName,
    this.initialValue,
    this.max,
    this.min,
    this.pattern,
    this.values,
  });

  @override
  State<NumberInput> createState() => NumberInputState();
}

class NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue?.toString());
    _controller.addListener(() => widget.controller?.value = _controller.text);
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
        controller: _controller,
        decoration: InputDecoration(labelText: translatedText),
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => validateInput(value),
      ),
    );
  }

  String? validateInput(input) {
    if (input.isEmpty) {
      return FlutterI18n.translate(context, 'errors.value_renderer.emptyField');
    } else {
      final numInput = num.parse(input);

      if (!validateMaxValue(numInput)) {
        return FlutterI18n.translate(context, 'errors.value_renderer.maxValue', translationParams: {'value': widget.max!.toString()});
      } else if (!validateMinValue(numInput)) {
        return FlutterI18n.translate(context, 'errors.value_renderer.minValue', translationParams: {'value': widget.min!.toString()});
      } else if (!validateFormat(input)) {
        return FlutterI18n.translate(context, 'errors.value_renderer.invalidFormat');
      } else if (!validateEquality(numInput)) {
        return FlutterI18n.translate(context, 'errors.value_renderer.invalidInput');
      } else {
        return null;
      }
    }
  }

  bool validateMaxValue(num input) {
    if (widget.max == null) return true;

    return input <= widget.max!;
  }

  bool validateMinValue(num input) {
    if (widget.min == null) return true;

    return input >= widget.min!;
  }

  bool validateEquality(num input) {
    if (widget.values == null) return true;

    return widget.values!.map((e) => e.key).contains(ValueHintsDefaultValueNum(input));
  }

  bool validateFormat(String input) {
    if (widget.pattern == null) return true;

    final valuePattern = RegExp(widget.pattern!);
    return valuePattern.hasMatch(input);
  }
}
