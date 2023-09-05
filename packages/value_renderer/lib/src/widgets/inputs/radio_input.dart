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

    final initialValue = widget.initialValue;

    selectedOption = initialValue;

    if (widget.controller != null) widget.controller!.value = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TranslatedText(widget.fieldName),
        ...widget.values.map((option) => RadioListTile<ValueHintsDefaultValue>(
              title: TranslatedText(option.displayName),
              value: option.key,
              groupValue: selectedOption,
              onChanged: (ValueHintsDefaultValue? value) {
                if (value == null) return;

                if (widget.controller != null) widget.controller!.value = value;

                setState(() {
                  selectedOption = value;
                });
              },
            )),
      ],
    );
  }
}
