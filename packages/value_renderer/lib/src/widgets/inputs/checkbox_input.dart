import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../value_renderer.dart';
import '../translated_text.dart';

class CheckboxInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String fieldName;
  final bool initialValue;
  final List<ValueHintsValue>? values;

  const CheckboxInput({
    super.key,
    this.controller,
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

    widget.controller?.value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: TranslatedText(widget.fieldName),
      value: isChecked,
      onChanged: (bool? value) {
        widget.controller?.value = value;

        setState(() {
          isChecked = value ?? false;
        });
      },
    );
  }
}
