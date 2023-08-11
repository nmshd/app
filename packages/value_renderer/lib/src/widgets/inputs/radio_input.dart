import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class RadioInput extends StatefulWidget {
  final String fieldName;
  final List<ValueHintsValue>? values;
  final dynamic initialValue;

  const RadioInput({super.key, required this.values, required this.fieldName, required this.initialValue});

  @override
  State<RadioInput> createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {
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
