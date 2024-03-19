import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:translated_text/translated_text.dart';

import '../../value_renderer.dart';

class ComplexItemRenderer extends StatelessWidget {
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String valueType;
  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;
  final List<String>? optionalValues;
  final List<String>? keys;
  final ValueRendererController? controller;
  final Map<String, ValueRendererController>? controllers;
  final String? translatedText;
  final AttributeValue? initialValue;
  final InputDecoration? decoration;

  const ComplexItemRenderer({
    required this.renderHints,
    required this.valueHints,
    required this.valueType,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
    this.optionalValues,
    this.keys,
    this.controller,
    this.controllers,
    this.translatedText,
    this.initialValue,
    this.decoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hintKeys = keys ?? renderHints.propertyHints!.keys;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (translatedText != null) ...[
          TranslatedText(translatedText!, style: const TextStyle(fontSize: 16.0, color: Color(0xFF42474E))),
          const SizedBox(height: 12),
        ],
        Column(
          children: hintKeys
              .map((key) {
                final fieldName = FlutterI18n.translate(context, 'attributes.values.$valueType.$key.label');
                final itemRenderHints = renderHints.propertyHints![key];
                final itemValueHints = valueHints.propertyHints![key] ?? const ValueHints();
                final itemInitialDynamicValue = initialValue?.toJson()[key];
                final itemInitialValue = itemInitialDynamicValue == null ? null : _ComplexAttributeValueChild(itemInitialDynamicValue);

                return ValueRenderer(
                  initialValue: itemInitialValue,
                  renderHints: itemRenderHints!,
                  valueHints: itemValueHints,
                  fieldName: optionalValues != null && !optionalValues!.contains(key) ? '$fieldName*' : fieldName,
                  controller: controllers?[key],
                  decoration: decoration,
                  expandFileReference: expandFileReference,
                  chooseFile: chooseFile,
                  openFileDetails: openFileDetails,
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
