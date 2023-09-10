import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../value_renderer.dart';
import '../utils/utils.dart';

class SegmentedButtonInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String fieldName;
  final ValueHintsDefaultValue? initialValue;
  final RenderHintsTechnicalType? technicalType;
  final List<ValueHintsValue> values;

  const SegmentedButtonInput({
    super.key,
    this.controller,
    required this.fieldName,
    required this.initialValue,
    this.technicalType,
    required this.values,
  });

  @override
  State<SegmentedButtonInput> createState() => _SegmentedButtonInputState();
}

class _SegmentedButtonInputState extends State<SegmentedButtonInput> {
  late ValueHintsDefaultValue? selectedSegment;

  @override
  void initState() {
    super.initState();

    selectedSegment = widget.initialValue;

    widget.controller?.value = ControllerTypeResolver.resolveType(
      inputValue: widget.initialValue,
      type: widget.technicalType!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        TranslatedText(widget.fieldName),
        const SizedBox(height: 12),
        SegmentedButton<ValueHintsDefaultValue>(
          segments: widget.values.map((ValueHintsValue value) {
            return ButtonSegment<ValueHintsDefaultValue>(
              value: value.key,
              label: Text(value.displayName),
            );
          }).toList(),
          selected: selectedSegment == null ? {} : {selectedSegment!},
          onSelectionChanged: (Set<ValueHintsDefaultValue> newSelection) {
            widget.controller?.value = ControllerTypeResolver.resolveType(
              inputValue: newSelection.first,
              type: widget.technicalType!,
            );

            setState(() {
              selectedSegment = newSelection.first;
            });
          },
        ),
      ],
    );
  }
}
