import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import '../inputs/inputs.dart';
import '../utils/utils.dart';
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
