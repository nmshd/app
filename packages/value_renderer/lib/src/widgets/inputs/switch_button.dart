import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  final String fieldName;
  final bool? initialValue;

  const SwitchButton({super.key, required this.fieldName, this.initialValue});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  late bool light;

  @override
  void initState() {
    super.initState();
    light = widget.initialValue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.fieldName),
        Switch(
          value: light,
          activeColor: Colors.blue,
          onChanged: (bool value) {
            setState(() {
              light = value;
            });
          },
        ),
      ],
    );
  }
}
