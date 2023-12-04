import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:translated_text/translated_text.dart';

import '../../value_renderer.dart';
import '../utils/utils.dart';
import 'styles/input_decoration.dart';

class DropdownSelectInput extends StatefulWidget {
  final ValueRendererController? controller;
  final InputDecoration? decoration;
  final String fieldName;
  final ValueHintsDefaultValue? initialValue;
  final RenderHintsTechnicalType technicalType;
  final List<ValueHintsValue> values;

  const DropdownSelectInput({
    super.key,
    this.controller,
    this.decoration,
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
    final fieldName = widget.fieldName;
    final translatedText = fieldName.startsWith('i18n://') ? FlutterI18n.translate(context, fieldName.substring(7)) : fieldName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<ValueHintsDefaultValue>(
          value: selectedOption,
          decoration: widget.decoration != null
              ? widget.decoration!.copyWith(labelText: translatedText)
              : inputDecoration.copyWith(labelText: translatedText),
          onChanged: (ValueHintsDefaultValue? newValue) {
            widget.controller?.value = ControllerTypeResolver.resolveType(
              inputValue: newValue,
              type: widget.technicalType,
            );

            setState(() {
              selectedOption = newValue;
            });
          },
          isExpanded: true,
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
