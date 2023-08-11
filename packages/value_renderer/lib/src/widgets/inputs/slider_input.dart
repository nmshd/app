import 'package:flutter/material.dart';

class SliderInput extends StatefulWidget {
  final double? initialValue;
  final String? fieldName;
  final double min;
  final double max;

  const SliderInput({super.key, this.initialValue, this.fieldName = '', required this.min, required this.max});

  @override
  State<SliderInput> createState() => _SliderInputState();
}

class _SliderInputState extends State<SliderInput> {
  late double currentSliderValue;

  @override
  void initState() {
    super.initState();
    currentSliderValue = widget.initialValue ?? widget.min;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 18,
        ),
        Text(widget.fieldName!),
        Slider(
          value: currentSliderValue,
          min: widget.min,
          max: widget.max,
          divisions: 4,
          label: currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              currentSliderValue = value;
            });
          },
        ),
      ],
    );
  }
}
