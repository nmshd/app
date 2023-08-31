import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../value_renderer.dart';
import '../translated_text.dart';

class RadioInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String fieldName;
  final ValueHintsDefaultValue? initialValue;
  final List<ValueHintsValue> values;

  const RadioInput({
    super.key,
    this.controller,
    required this.fieldName,
    required this.initialValue,
    required this.values,
  });

  @override
  State<RadioInput> createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {
  late ValueHintsDefaultValue? selectedOption;

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
        const SizedBox(height: 20),
        TranslatedText(
          widget.fieldName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        ...widget.values.map((option) => RadioListTile<ValueHintsDefaultValue>(
              title: TranslatedText(option.displayName),
              value: option.key,
              groupValue: selectedOption,
              onChanged: (ValueHintsDefaultValue? value) {
                if (value == null) return;

                setState(() {
                  selectedOption = value;
                });
              },
            )),
      ],
    );
  }
}
