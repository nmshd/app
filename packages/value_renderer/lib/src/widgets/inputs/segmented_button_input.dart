import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class SegmentedButtonInput extends StatefulWidget {
  const SegmentedButtonInput({super.key, required this.fieldName, required this.values, this.initialValue});

  final String fieldName;
  final List<ValueHintsValue> values;
  final dynamic initialValue;

  @override
  State<SegmentedButtonInput> createState() => _SegmentedButtonInputState();
}

class _SegmentedButtonInputState extends State<SegmentedButtonInput> {
  dynamic selectedSegment;

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
        Text(widget.fieldName),
        const SizedBox(
          height: 18,
        ),
        SegmentedButton<dynamic>(
          segments: widget.values.map((dynamic value) {
            return ButtonSegment<dynamic>(
              value: value.key,
              label: Text(value.key.toString()),
            );
          }).toList(),
          selected: {selectedSegment},
          onSelectionChanged: (Set<dynamic> newSelection) {
            setState(() {
              selectedSegment = newSelection.first;
            });
          },
        ),
      ],
    );
  }
}
