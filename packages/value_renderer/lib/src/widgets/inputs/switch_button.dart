import 'package:flutter/material.dart';

class SwitchInput extends StatefulWidget {
  final String fieldName;
  final bool? initialValue;

  const SwitchInput({
    super.key,
    required this.fieldName,
    this.initialValue,
  });

  @override
  State<SwitchInput> createState() => _SwitchInputState();
}

class _SwitchInputState extends State<SwitchInput> {
  late bool enabled;

  @override
  void initState() {
    super.initState();
    enabled = widget.initialValue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.fieldName),
        Switch(
          value: enabled,
          activeColor: Colors.blue,
          onChanged: (bool value) {
            setState(() {
              enabled = value;
            });
          },
        ),
      ],
    );
  }
}
