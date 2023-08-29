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
    final fieldName = widget.fieldName;
    final translatedText = fieldName.startsWith('i18n://') ? FlutterI18n.translate(context, fieldName.substring(7)) : fieldName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: translatedText),
          keyboardType: TextInputType.number,
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
        errorMessage = 'This field cannot be empty.';
      } else if (!validateEquality(_controller.text)) {
        errorMessage = 'Invalid Input';
      } else {
        errorMessage = null;
      }
    });
  }

  bool validateEquality(String input) {
    int result = 1;
    if (widget.values != null) {
      result = widget.values!.indexWhere((element) => element.key == ValueHintsDefaultValueNum(int.parse(input)));
    }

    return result == -1 ? false : true;
  }
}
