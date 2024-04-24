import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '../utils/controller_type_resolver.dart';
import '../value_renderer_controller.dart';

class SliderInput extends StatefulWidget {
  final ValueRendererController? controller;
  final String? fieldName;
  final num? initialValue;
  final num max;
  final num min;
  final RenderHintsTechnicalType? technicalType;

  const SliderInput({
    super.key,
    this.controller,
    this.fieldName,
    this.initialValue,
    required this.max,
    required this.min,
    this.technicalType,
  });

  @override
  State<SliderInput> createState() => _SliderInputState();
}

class _SliderInputState extends State<SliderInput> {
  late num currentSliderValue;

  @override
  void initState() {
    super.initState();

    currentSliderValue = widget.initialValue ?? widget.min;

    widget.controller?.value = ControllerTypeResolver.resolveType(
      inputValue: ValueHintsDefaultValueNum(currentSliderValue),
      type: widget.technicalType!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        if (widget.fieldName != null) TranslatedText(widget.fieldName!),
        Slider(
          value: currentSliderValue.toDouble(),
          min: widget.min.toDouble(),
          max: widget.max.toDouble(),
          divisions: widget.technicalType == RenderHintsTechnicalType.Float ? widget.max.toInt() * 10 : widget.max.toInt() - widget.min.toInt(),
          label:
              widget.technicalType == RenderHintsTechnicalType.Float ? currentSliderValue.toStringAsFixed(2) : currentSliderValue.round().toString(),
          onChanged: (num value) {
            widget.controller?.value = ControllerTypeResolver.resolveType(
              inputValue: ValueHintsDefaultValueNum(value),
              type: widget.technicalType!,
            );

            setState(() {
              currentSliderValue = value;
            });
          },
        ),
      ],
    );
  }
}
