import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RadioButton extends StatefulWidget {
  RadioButton({super.key, required this.values, required this.fieldName, required this.initialValue});

  final String fieldName;
  late List<dynamic> values;
  final dynamic initialValue;

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  late dynamic selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue.toString();
    if (widget.values.isEmpty) {
      widget.values = [
        {'key': 'true'},
        {'key': 'false'}
      ];
    }
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
        ...widget.values.map((option) => RadioListTile<dynamic>(
              title: Text(option['key'].toString()),
              value: option['key']!,
              groupValue: selectedOption,
              onChanged: (dynamic value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            )),
      ],
    );
  }
}
