import 'package:flutter/material.dart';

class SliderInput extends StatefulWidget {
  final String fieldName;
  final num? initialValue;
  final num? min;
  final num? max;

  const SliderInput({
    super.key,
    this.initialValue,
    required this.fieldName,
    this.min,
    this.max,
  });

  @override
  State<SliderInput> createState() => _SliderInputState();
}

class _SliderInputState extends State<SliderInput> {
  late double currentSliderValue;

  @override
  void initState() {
    super.initState();
    currentSliderValue = widget.initialValue?.toDouble() ?? widget.min!.toDouble();
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
        Slider(
          value: currentSliderValue,
          min: widget.min!.toDouble(),
          max: widget.max!.toDouble(),
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
