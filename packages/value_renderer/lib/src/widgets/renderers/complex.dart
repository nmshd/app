import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
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
  final bool shouldTranslate;

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
    required this.shouldTranslate,
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
    final fieldName = widget.shouldTranslate ? 'i18n://attributes.values.${widget.fieldName}._title' : widget.fieldName;
    final translatedText = fieldName.startsWith('i18n://') ? FlutterI18n.translate(context, fieldName.substring(7)) : fieldName;

    if (widget.initialValue is BirthDateAttributeValue || widget.fieldName == 'BirthDate') {
      return DatepickerFormField(
        controller: widget.controller,
        initialValueAttribute: widget.initialValue,
        fieldName: translatedText,
        decoration: widget.decoration,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        TranslatedText(
          fieldName,
          style: const TextStyle(fontSize: 16.0, color: Color(0xFF42474E)),
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
            final translatedKey = 'i18n://attributes.values.${widget.fieldName}.$key.label';
            final itemInitialDynamicValue = widget.initialValue?.toJson()[key];
            final itemInitialValue = itemInitialDynamicValue == null ? null : _ComplexAttributeValueChild(itemInitialDynamicValue);
            final itemRenderHints = widget.renderHints.propertyHints![key];
            final itemValueHints = widget.valueHints.propertyHints![key];

            return Column(
              children: [
                ValueRenderer(
                  initialValue: itemInitialValue,
                  renderHints: itemRenderHints!,
                  valueHints: itemValueHints!,
                  fieldName: translatedKey,
                  controller: controllers?[key],
                  shouldTranslate: widget.shouldTranslate,
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ComplexAttributeValueChild extends AttributeValue {
  final dynamic value;

  const _ComplexAttributeValueChild(this.value) : super('Dummy');

  @override
  Map<String, dynamic> toJson() => {'value': value};

  @override
  List<Object?> get props => [value];
}
