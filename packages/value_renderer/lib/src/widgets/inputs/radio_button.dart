import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key, required this.values, required this.fieldName, required this.initialValue});

  final String fieldName;
  final List<dynamic> values;
  final String initialValue;

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.fieldName),
        ...widget.values.map((option) => RadioListTile<String>(
              title: Text(option['key']!),
              value: option['key']!,
              groupValue: selectedOption,
              onChanged: (String? value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            )),
      ],
    );
  }
}
