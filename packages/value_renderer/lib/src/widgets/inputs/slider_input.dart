import 'package:flutter/material.dart';

import '../../value_renderer.dart';
import '../translated_text.dart';

class SliderInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String fieldName;
  final num? initialValue;
  final num max;
  final num min;

  const SliderInput({
    super.key,
    this.controller,
    required this.fieldName,
    this.initialValue,
    required this.max,
    required this.min,
  });

  @override
  State<SliderInput> createState() => _SliderInputState();
}

class _SliderInputState extends State<SliderInput> {
  late double currentSliderValue;

  @override
  void initState() {
    super.initState();

    currentSliderValue = widget.initialValue?.toDouble() ?? widget.min.toDouble();

    widget.controller?.value = currentSliderValue;
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
          min: widget.min.toDouble(),
          max: widget.max.toDouble(),
          //TODO: Define a value for number of divisions
          divisions: 4,
          label: currentSliderValue.round().toString(),
          onChanged: (double value) {
            widget.controller?.value = value;

            setState(() {
              currentSliderValue = value;
            });
          },
        ),
      ],
    );
  }
}
