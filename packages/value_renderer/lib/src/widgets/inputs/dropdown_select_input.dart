import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../value_renderer.dart';
import '../translated_text.dart';

class DropdownSelectInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String fieldName;
  final ValueHintsDefaultValue? initialValue;
  final List<ValueHintsValue> values;

  const DropdownSelectInput({
    super.key,
    this.controller,
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

    final initialValue = widget.initialValue;

    selectedOption = initialValue;

    if (widget.controller != null) widget.controller!.value = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TranslatedText(widget.fieldName),
        ),
        DropdownButton<ValueHintsDefaultValue>(
          value: selectedOption,
          onChanged: (ValueHintsDefaultValue? newValue) {
            if (widget.controller != null) widget.controller!.value = newValue;

            setState(() {
              selectedOption = newValue;
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
