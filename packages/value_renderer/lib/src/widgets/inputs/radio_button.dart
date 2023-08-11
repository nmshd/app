import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  final String fieldName;
  final List<ValueHintsValue>? values;
  final dynamic initialValue;

  const RadioButton({super.key, required this.values, required this.fieldName, required this.initialValue});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  late dynamic selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Text(
          widget.fieldName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        ...widget.values!.map((option) => RadioListTile<dynamic>(
              title: Text(option.key.toString()),
              value: option.key!.toString(),
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
