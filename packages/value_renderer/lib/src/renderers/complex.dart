import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:translated_text/translated_text.dart';

import '../inputs/inputs.dart';
import '../utils/utils.dart';
import '../value_renderer.dart';
import '../value_renderer_controller.dart';
import 'address/address.dart';

class ComplexRenderer extends StatelessWidget {
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
  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

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
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    final translatedText = fieldName == null
        ? null
        : fieldName!.startsWith('i18n://')
            ? FlutterI18n.translate(context, fieldName!.substring(7))
            : fieldName;

    if (initialValue is BirthDateAttributeValue || valueType == 'BirthDate') {
      return DatepickerFormField(
        controller: controller,
        emptyFieldMessage: FlutterI18n.translate(context, 'errors.value_renderer.emptyField'),
        initialValueAttribute: initialValue,
        decoration: decoration,
        fieldName: translatedText,
        mustBeFilledOut: mustBeFilledOut,
        dateFormat: DateFormat.yMd(Localizations.localeOf(context).languageCode),
      );
    }

    if (initialValue is StreetAddressAttributeValue || valueType == 'StreetAddress') {
      return StreetAddressRenderer(
        translatedText: translatedText,
        controller: controller,
        renderHints: renderHints,
        valueHints: valueHints,
        initialValue: initialValue != null ? initialValue as StreetAddressAttributeValue : null,
        decoration: decoration,
      );
    }

    if (initialValue is DeliveryBoxAddressAttributeValue || valueType == 'DeliveryBoxAddress') {
      return DeliveryBoxAddressRenderer(
        translatedText: translatedText,
        controller: controller,
        renderHints: renderHints,
        valueHints: valueHints,
        initialValue: initialValue != null ? initialValue as DeliveryBoxAddressAttributeValue : null,
        decoration: decoration,
      );
    }

    if (initialValue is PostOfficeBoxAddressAttributeValue || valueType == 'PostOfficeBoxAddress') {
      return PostOfficeBoxAddressRenderer(
        translatedText: translatedText,
        controller: controller,
        renderHints: renderHints,
        valueHints: valueHints,
        initialValue: initialValue != null ? initialValue as PostOfficeBoxAddressAttributeValue : null,
        decoration: decoration,
      );
    }

    return _GenericComplexRenderer(
      translatedText: translatedText,
      controller: controller,
      renderHints: renderHints,
      valueHints: valueHints,
      valueType: valueType,
      initialValue: initialValue,
      decoration: decoration,
      expandFileReference: expandFileReference,
      chooseFile: chooseFile,
      openFileDetails: openFileDetails,
    );
  }
}

class _GenericComplexRenderer extends StatefulWidget {
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String valueType;
  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;
  final ValueRendererController? controller;
  final AttributeValue? initialValue;
  final InputDecoration? decoration;
  final String? translatedText;

  const _GenericComplexRenderer({
    required this.renderHints,
    required this.valueHints,
    required this.valueType,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
    this.controller,
    this.initialValue,
    this.decoration,
    this.translatedText,
  });

  @override
  State<_GenericComplexRenderer> createState() => _GenericComplexRendererState();
}

class _GenericComplexRendererState extends State<_GenericComplexRenderer> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.translatedText != null) ...[
          TranslatedText(widget.translatedText!, style: const TextStyle(fontSize: 16.0, color: Color(0xFF42474E))),
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
                    decoration: widget.decoration,
                    expandFileReference: widget.expandFileReference,
                    chooseFile: widget.chooseFile,
                    openFileDetails: widget.openFileDetails,
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
