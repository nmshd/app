import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class NumberInput extends StatefulWidget {
  final String fieldName;
  final num? initialValue;
  final int? max;
  final int? min;
  final List<ValueHintsValue>? values;

  const NumberInput({
    super.key,
    required this.fieldName,
    this.initialValue,
    this.max,
    this.min,
    this.values,
  });

  @override
  State<NumberInput> createState() => NumberInputState();
}

class NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue?.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    final fieldName = widget.fieldName;
    final translatedText = fieldName.startsWith('i18n://') ? FlutterI18n.translate(context, fieldName.substring(7)) : fieldName;

    return Form(
      key: formKey,
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
      final numInput = int.parse(input);

      if (!validateMaxValue(numInput)) {
        return '${FlutterI18n.translate(context, 'errors.value_renderer.maxValue')}${widget.max}';
      } else if (!validateMinValue(numInput)) {
        return '${FlutterI18n.translate(context, 'errors.value_renderer.minValue')}${widget.min}';
      } else if (!validateEquality(numInput)) {
        return FlutterI18n.translate(context, 'errors.value_renderer.invalidInput');
      } else {
        return null;
      }
    }
  }

  bool validateMaxValue(int input) {
    if (widget.max == null) return true;
    return input <= widget.max!.toInt();
  }

  bool validateMinValue(int input) {
    if (widget.min == null) return true;
    return input >= widget.min!.toInt();
  }

  bool validateEquality(int input) {
    if (widget.values == null) return true;
    return widget.values!.map((e) => e.key).contains(ValueHintsDefaultValueNum(input));
  }
}
