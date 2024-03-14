import 'package:collection/collection.dart';
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
  final RenderHintsDataType? dataType;
  final List<ValueHintsValue> values;

  const DropdownSelectInput({
    super.key,
    this.controller,
    this.decoration,
    this.fieldName,
    this.initialValue,
    required this.mustBeFilledOut,
    required this.technicalType,
    required this.dataType,
    required this.values,
  });

  @override
  State<DropdownSelectInput> createState() => _DropdownSelectInputState();
}

class _DropdownSelectInputState extends State<DropdownSelectInput> {
  late ValueHintsDefaultValue? _selectedOption;

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
    String? translatedText;

    if (widget.fieldName != null) {
      translatedText = widget.fieldName!.startsWith('i18n://') ? FlutterI18n.translate(context, widget.fieldName!.substring(7)) : widget.fieldName!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<ValueHintsDefaultValue>(
          autovalidateMode: AutovalidateMode.always,
          value: _selectedOption,
          decoration: widget.decoration != null
              ? widget.decoration!.copyWith(labelText: translatedText)
              : inputDecoration.copyWith(labelText: translatedText),
          validator: (value) => value == null && widget.mustBeFilledOut
              ? FlutterI18n.translate(
                  context,
                  'errors.value_renderer.emptyField',
                )
              : null,
          onChanged: (ValueHintsDefaultValue? newValue) {
            widget.controller?.value = ControllerTypeResolver.resolveType(
              inputValue: newValue is ValueHintsDefaultValueString && newValue.value.startsWith('dup_')
                  ? ValueHintsDefaultValueString(newValue.value.substring(4))
                  : newValue,
              type: widget.technicalType,
            );

            setState(() => _selectedOption = newValue);
          },
          isExpanded: true,
          items: _buildMenuItems(),
        ),
      ],
    );
  }

  List<DropdownMenuItem<ValueHintsDefaultValue>> _buildMenuItems() {
    final translated = widget.values
        .map(
          (e) => (
            key: e.key,
            translation: e.displayName.startsWith('i18n://') ? FlutterI18n.translate(context, e.displayName.substring(7)) : e.displayName,
          ),
        )
        .toList();

    translated.sort((a, b) => a.translation.compareTo(b.translation));

    if (widget.dataType == RenderHintsDataType.Country) {
      final de = translated.firstWhereOrNull((e) => e.key.toJson() == 'DE');
      final at = translated.firstWhereOrNull((e) => e.key.toJson() == 'AT');
      final ch = translated.firstWhereOrNull((e) => e.key.toJson() == 'CH');

      translated.insertAll(0, [
        if (de != null) (key: const ValueHintsDefaultValueString('dup_DE'), translation: de.translation),
        if (at != null) (key: const ValueHintsDefaultValueString('dup_AT'), translation: at.translation),
        if (ch != null) (key: const ValueHintsDefaultValueString('dup_CH'), translation: ch.translation),
      ]);
    } else if (widget.dataType == RenderHintsDataType.Language) {
      final de = translated.firstWhereOrNull((e) => e.key.toJson() == 'de');
      final en = translated.firstWhereOrNull((e) => e.key.toJson() == 'en');

      translated.insertAll(0, [
        if (de != null) (key: const ValueHintsDefaultValueString('dup_de'), translation: de.translation),
        if (en != null) (key: const ValueHintsDefaultValueString('dup_en'), translation: en.translation),
      ]);
    }

    return translated
        .map((e) => DropdownMenuItem<ValueHintsDefaultValue>(
              value: e.key,
              child: TranslatedText(e.translation),
            ))
        .toList();
  }
}
