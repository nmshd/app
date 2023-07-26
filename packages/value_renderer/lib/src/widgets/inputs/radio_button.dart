import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key, required this.values, required this.fieldName, required this.initialValue});

  final String fieldName;
  final List<dynamic> values;
  final dynamic initialValue;

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.fieldName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
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
