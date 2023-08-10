import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class CheckboxButton extends StatefulWidget {
  final String fieldName;
  final List<ValueHintsValue> values;
  final dynamic initialValue;

  const CheckboxButton({super.key, required this.fieldName, this.initialValue, required this.values});

  @override
  State<CheckboxButton> createState() => _CheckboxButtonState();
}

class _CheckboxButtonState extends State<CheckboxButton> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.fieldName),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
        });
      },
    );
  }
}
