import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class SegmentedButtonInput extends StatefulWidget {
  final String fieldName;
  final ValueHintsDefaultValue? initialValue;
  final List<ValueHintsValue> values;

  const SegmentedButtonInput({
    super.key,
    required this.fieldName,
    required this.initialValue,
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 18,
        ),
        Text(widget.fieldName),
        const SizedBox(
          height: 12,
        ),
        SegmentedButton<ValueHintsDefaultValue>(
          segments: widget.values.map((ValueHintsValue value) {
            return ButtonSegment<ValueHintsDefaultValue>(
              value: value.key,
              label: Text(value.displayName),
            );
          }).toList(),
          selected: selectedSegment == null ? {} : {selectedSegment!},
          onSelectionChanged: (Set<ValueHintsDefaultValue> newSelection) {
            setState(() {
              selectedSegment = newSelection.first;
            });
          },
        ),
      ],
    );
  }
}
