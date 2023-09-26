import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../value_renderer.dart';
import '../inputs/inputs.dart';

class ComplexRenderer extends StatefulWidget {
  final ValueRendererController? controller;
  final InputDecoration? decoration;
  final RenderHintsDataType? dataType;
  final RenderHintsEditType? editType;
  final String fieldName;
  final AttributeValue? initialValue;
  final RenderHints renderHints;
  final ValueHints valueHints;

  const ComplexRenderer({
    super.key,
    this.controller,
    this.decoration,
    this.dataType,
    this.editType,
    required this.fieldName,
    required this.initialValue,
    required this.renderHints,
    required this.valueHints,
  });

  @override
  State<ComplexRenderer> createState() => _ComplexRendererState();
}

class _ComplexRendererState extends State<ComplexRenderer> {
  Map<String, dynamic> value = {};

  Map<String, ValueRendererController>? controllers;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      controllers = <String, ValueRendererController>{};

      for (final key in widget.renderHints.propertyHints!.keys) {
        final controller = ValueRendererController();
        controllers![key] = controller;

        controller.addListener(() {
          value[key] = controller.value;
          widget.controller!.value = Map<String, dynamic>.from(value);
        });
      }
    }
  }

  @override
  void dispose() {
    if (controllers != null) {
      for (final controller in controllers!.values) {
        controller.dispose();
      }
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue is BirthDateAttributeValue) {
      return DatepickerFormField(
        controller: widget.controller,
        initialValueAttribute: widget.initialValue,
        fieldName: widget.fieldName,
        decoration: widget.decoration ??
            InputDecoration(
              hintStyle: const TextStyle(color: Colors.black45),
              errorStyle: const TextStyle(color: Colors.redAccent),
              suffixIcon: const Icon(Icons.calendar_month),
              //TODO: Translate fieldName
              labelText: widget.fieldName,
            ),
      );
    }
    //
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        TranslatedText(
          widget.fieldName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.renderHints.propertyHints?.values.length,
          itemBuilder: (context, index) {
            final key = widget.renderHints.propertyHints!.keys.elementAt(index);
            final itemInitialDynamicValue = widget.initialValue?.toJson()[key];
            final itemInitialValue = itemInitialDynamicValue == null ? null : _ComplexAttributeValueChild(itemInitialDynamicValue);
            final itemRenderHints = widget.renderHints.propertyHints![key];
            final itemValueHints = widget.valueHints.propertyHints![key];

            return ListTile(
              title: ValueRenderer(
                initialValue: itemInitialValue,
                renderHints: itemRenderHints!,
                valueHints: itemValueHints!,
                fieldName: key,
                controller: controllers?[key],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ComplexAttributeValueChild extends AttributeValue {
  final dynamic value;

  const _ComplexAttributeValueChild(this.value);

  @override
  Map<String, dynamic> toJson() => {'value': value};

  @override
  List<Object?> get props => [value];
}
