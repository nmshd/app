import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:translated_text/translated_text.dart';

import '../utils/utils.dart';
import '../value_renderer_controller.dart';
import 'styles/input_decoration.dart';

class DropdownSelectInput extends StatefulWidget {
  final ValueRendererController? controller;
  final InputDecoration? decoration;
  final String? fieldName;
  final ValueHintsDefaultValue? initialValue;
  final bool mustBeFilledOut;
  final RenderHintsTechnicalType technicalType;
  final List<ValueHintsValue> values;

  const DropdownSelectInput({
    super.key,
    this.controller,
    this.decoration,
    this.fieldName,
    this.initialValue,
    required this.mustBeFilledOut,
    required this.technicalType,
    required this.values,
  });

  @override
  State<DropdownSelectInput> createState() => _DropdownSelectInputState();
}

class _DropdownSelectInputState extends State<DropdownSelectInput> {
  late ValueHintsDefaultValue? _selectedOption;
  String? _translatedText;

  @override
  void initState() {
    super.initState();

    _selectedOption = widget.initialValue;

    if (widget.initialValue != null) {
      widget.controller?.value = ControllerTypeResolver.resolveType(
        inputValue: widget.initialValue,
        type: widget.technicalType,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fieldName != null) {
      _translatedText = widget.fieldName!.startsWith('i18n://') ? FlutterI18n.translate(context, widget.fieldName!.substring(7)) : widget.fieldName!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<ValueHintsDefaultValue>(
          autovalidateMode: AutovalidateMode.always,
          value: _selectedOption,
          decoration: widget.decoration != null
              ? widget.decoration!.copyWith(labelText: _translatedText)
              : inputDecoration.copyWith(labelText: _translatedText),
          validator: (value) => value == null && widget.mustBeFilledOut
              ? FlutterI18n.translate(
                  context,
                  'errors.value_renderer.emptyField',
                )
              : null,
          onChanged: (ValueHintsDefaultValue? newValue) {
            widget.controller?.value = ControllerTypeResolver.resolveType(
              inputValue: newValue,
              type: widget.technicalType,
            );

            setState(() => _selectedOption = newValue);
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
