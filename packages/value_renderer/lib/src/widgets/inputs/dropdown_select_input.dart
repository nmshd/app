import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../value_renderer.dart';
import '../utils/utils.dart';

class DropdownSelectInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String fieldName;
  final ValueHintsDefaultValue? initialValue;
  final RenderHintsTechnicalType technicalType;
  final List<ValueHintsValue> values;

  const DropdownSelectInput({
    super.key,
    this.controller,
    required this.fieldName,
    required this.initialValue,
    required this.technicalType,
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

    widget.controller?.value = ControllerTypeResolver.resolveType(
      inputValue: widget.initialValue,
      type: widget.technicalType,
    );
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
        DropdownButtonFormField<ValueHintsDefaultValue>(
          value: selectedOption,
          onChanged: (ValueHintsDefaultValue? newValue) {
            widget.controller?.value = ControllerTypeResolver.resolveType(
              inputValue: newValue,
              type: widget.technicalType,
            );

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
