import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int _radioOption = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<int>(
          title: const Text('Radio 1'),
          value: 1,
          groupValue: _radioOption,
          onChanged: (int? value) {
            setState(() {
              _radioOption = value!;
            });
          },
        ),
        RadioListTile<int>(
          title: const Text('Radio 2'),
          value: 2,
          groupValue: _radioOption,
          onChanged: (int? value) {
            setState(() {
              _radioOption = value!;
            });
          },
        ),
      ],
    );
  }
}
