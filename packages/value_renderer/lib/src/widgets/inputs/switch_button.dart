import 'package:flutter/material.dart';

import '../../value_renderer.dart';
import '../utils/translated_text.dart';

class SwitchInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String fieldName;
  final bool? initialValue;

  const SwitchInput({
    super.key,
    this.controller,
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

    widget.controller?.value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TranslatedText(widget.fieldName),
        Switch(
          value: enabled,
          activeColor: Colors.blue,
          onChanged: (bool value) {
            widget.controller?.value = value;

            setState(() {
              enabled = value;
            });
          },
        ),
      ],
    );
  }
}
