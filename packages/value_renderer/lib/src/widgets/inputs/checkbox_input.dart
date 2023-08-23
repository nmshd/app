import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../translated_text.dart';

class CheckboxInput extends StatefulWidget {
  final String fieldName;
  final bool initialValue;
  final List<ValueHintsValue>? values;

  const CheckboxInput({
    super.key,
    required this.fieldName,
    required this.initialValue,
    this.values,
  });

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

class _CheckboxInputState extends State<CheckboxInput> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: TranslatedText(widget.fieldName),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
        });
      },
    );
  }
}
