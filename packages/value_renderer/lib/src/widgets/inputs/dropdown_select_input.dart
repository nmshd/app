import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../translated_text.dart';

class DropdownSelectInput extends StatefulWidget {
  final String fieldName;
  final ValueHintsDefaultValue? initialValue;
  final List<ValueHintsValue> values;

  const DropdownSelectInput({
    super.key,
    required this.fieldName,
    required this.initialValue,
    required this.values,
  });

  @override
  State<DropdownSelectInput> createState() => _DropdownSelectInputState();
}

class _DropdownSelectInputState extends State<DropdownSelectInput> {
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
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: TranslatedText(widget.fieldName),
        ), // Label
        DropdownButton<dynamic>(
          value: selectedOption,
          onChanged: (dynamic newValue) {
            setState(() {
              selectedOption = newValue!;
            });
          },
          items: widget.values.map<DropdownMenuItem<ValueHintsDefaultValue>>((ValueHintsValue value) {
            return DropdownMenuItem<ValueHintsDefaultValue>(
              value: value.key,
              child: TranslatedText(value.displayName),
            );
          }).toList(),
        ),
      ],
    );
  }
}
