import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:translated_text/translated_text.dart';

import '../inputs/inputs.dart';
import '../utils/utils.dart';
import '../value_renderer.dart';
import '../value_renderer_controller.dart';
import 'renderers.dart';

class ComplexRenderer extends StatefulWidget {
  final ValueRendererController? controller;
  final InputDecoration? decoration;
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
  State<ComplexRenderer> createState() => _ComplexRendererState();
}

class _ComplexRendererState extends State<ComplexRenderer> {
  final Map<String, dynamic> _value = {};
  Map<String, ValueRendererController>? _controllers;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _controllers = <String, ValueRendererController>{};

      for (final key in widget.renderHints.propertyHints!.keys) {
        final controller = ValueRendererController();
        _controllers![key] = controller;

        controller.addListener(() {
          _value[key] = controller.value;
          widget.controller!.value = ValueRendererInputValueMap(Map<String, dynamic>.from(_value));
        });
      }
    }
  }

  @override
  void dispose() {
    if (_controllers != null) {
      for (final controller in _controllers!.values) {
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

    if (_isAddress) {
      return AddressRenderer(
        controller: widget.controller,
        translatedText: translatedText,
        renderHints: widget.renderHints,
        valueHints: widget.valueHints,
        expandFileReference: widget.expandFileReference,
        chooseFile: widget.chooseFile,
        openFileDetails: widget.openFileDetails,
        valueType: widget.valueType,
      );
    }

    return ComplexItemRenderer(
      initialValue: widget.initialValue,
      renderHints: widget.renderHints,
      valueHints: widget.valueHints,
      translatedText: translatedText,
      controller: widget.controller,
      decoration: widget.decoration,
      expandFileReference: widget.expandFileReference,
      chooseFile: widget.chooseFile,
      openFileDetails: widget.openFileDetails,
      controllers: _controllers,
      valueType: widget.valueType,
    );

    /*

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
    );*/
  }

  bool get _isAddress => _isOfTypeAddress(widget.initialValue?.atType) || _isOfTypeAddress(widget.valueType);

  bool _isOfTypeAddress(String? valueType) {
    return [
      'StreetAddress',
      'StreetAddressAttributeValue',
      'DeliveryBoxAddress',
      'DeliveryBoxAddressAttributeValue',
      'PostOfficeBoxAddress',
      'PostOfficeBoxAddressAttributeValue'
    ].contains(valueType);
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

class ComplexItemRenderer extends StatelessWidget {
  final ValueRendererController? controller;
  final InputDecoration? decoration;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String? translatedText;
  final Map<String, ValueRendererController>? controllers;
  final String valueType;
  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;
  final AttributeValue? initialValue;

  const ComplexItemRenderer({
    super.key,
    this.controller,
    this.decoration,
    this.translatedText,
    required this.renderHints,
    required this.valueHints,
    this.controllers,
    required this.valueType,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (translatedText != null) ...[
          TranslatedText(translatedText!, style: const TextStyle(fontSize: 16.0, color: Color(0xFF42474E))),
          const SizedBox(height: 12),
        ],
        Column(
          children: renderHints.propertyHints!.keys
              .map((key) {
                final translatedKey = 'i18n://attributes.values.$valueType.$key.label';

                final itemRenderHints = renderHints.propertyHints![key];
                final itemValueHints = valueHints.propertyHints![key] ?? const ValueHints();
                final itemInitialDynamicValue = initialValue?.toJson()[key];
                final itemInitialValue = itemInitialDynamicValue == null ? null : _ComplexAttributeValueChild(itemInitialDynamicValue);

                return ValueRenderer(
                  initialValue: itemInitialValue,
                  renderHints: itemRenderHints!,
                  valueHints: itemValueHints,
                  fieldName: translatedKey,
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
