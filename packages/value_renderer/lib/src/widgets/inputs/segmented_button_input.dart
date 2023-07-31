import 'package:flutter/material.dart';

class SegmentedButtonInput extends StatefulWidget {
  const SegmentedButtonInput({super.key, required this.fieldName, required this.values, this.initialValue});

  final String fieldName;
  final List<dynamic> values;
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
          segments: [
            ButtonSegment<dynamic>(
              value: widget.initialValue,
              label: Text(widget.initialValue.toString()),
            ),
            ...widget.values.map((dynamic value) {
              return ButtonSegment<dynamic>(
                value: value['key'],
                label: Text(value['key'].toString()),
              );
            })
          ],
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
