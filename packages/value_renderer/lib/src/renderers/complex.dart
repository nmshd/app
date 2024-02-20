import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:translated_text/translated_text.dart';

import '../inputs/inputs.dart';
import '../utils/utils.dart';
import '../value_renderer.dart';
import '../value_renderer_controller.dart';

class ComplexRenderer extends StatefulWidget {
  final ValueRendererController? controller;
  final InputDecoration? decoration;
  final RenderHintsDataType? dataType;
  final RenderHintsEditType? editType;
  final String? fieldName;
  final AttributeValue? initialValue;
  final bool mustBeFilledOut;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String valueType;

  const ComplexRenderer({
    super.key,
    this.controller,
    this.decoration,
    this.dataType,
    this.editType,
    this.fieldName,
    required this.initialValue,
    required this.mustBeFilledOut,
    required this.renderHints,
    required this.valueHints,
    required this.valueType,
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
          widget.controller!.value = ValueRendererInputValueMap(Map<String, dynamic>.from(value));
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
    String? translatedText;

    if (widget.fieldName != null) {
      translatedText = widget.fieldName!.startsWith('i18n://') ? FlutterI18n.translate(context, widget.fieldName!.substring(7)) : widget.fieldName;
    }

    if (widget.initialValue is BirthDateAttributeValue || widget.valueType == 'BirthDate') {
      return DatepickerFormField(
        controller: widget.controller,
        emptyFieldMessage: FlutterI18n.translate(context, 'errors.value_renderer.emptyField'),
        initialValueAttribute: widget.initialValue,
        decoration: widget.decoration,
        fieldName: translatedText,
        mustBeFilledOut: widget.mustBeFilledOut,
        dateFormat: DateFormat.yMd(Localizations.localeOf(context).languageCode),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (translatedText != null) ...[
          TranslatedText(translatedText, style: const TextStyle(fontSize: 16.0, color: Color(0xFF42474E))),
          const SizedBox(height: 12),
        ],
        if (widget.renderHints.propertyHints != null)
          Column(
            children: widget.renderHints.propertyHints!.keys
                .map((key) {
                  final translatedKey = 'i18n://attributes.values.${widget.valueType}.$key.label';

                  final itemInitialDynamicValue = widget.initialValue?.toJson()[key];
                  final itemInitialValue = itemInitialDynamicValue == null ? null : _ComplexAttributeValueChild(itemInitialDynamicValue);
                  final itemRenderHints = widget.renderHints.propertyHints![key];
                  final itemValueHints = widget.valueHints.propertyHints![key] ?? const ValueHints();

                  return ValueRenderer(
                    initialValue: itemInitialValue,
                    renderHints: itemRenderHints!,
                    valueHints: itemValueHints,
                    fieldName: translatedKey,
                    controller: controllers?[key],
                  );
                })
                .indexed
                .map((e) => e.$1 == 0 ? e.$2 : Padding(padding: const EdgeInsets.only(top: 16), child: e.$2))
                .toList(),
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
