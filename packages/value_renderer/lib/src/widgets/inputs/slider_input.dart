import 'package:flutter/material.dart';

import '../translated_text.dart';

class SliderInput extends StatefulWidget {
  final String fieldName;
  final num? initialValue;
  final num? max;
  final num? min;

  const SliderInput({
    super.key,
    required this.fieldName,
    this.initialValue,
    this.max,
    this.min,
  });

  @override
  State<SliderInput> createState() => _SliderInputState();
}

class _SliderInputState extends State<SliderInput> {
  late double currentSliderValue;

  @override
  void initState() {
    super.initState();
    if (widget.min == null || widget.max == null) {
      throw Exception('trying to render without a min/max value');
    }
    currentSliderValue = widget.initialValue?.toDouble() ?? widget.min!.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        TranslatedText(widget.fieldName),
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
