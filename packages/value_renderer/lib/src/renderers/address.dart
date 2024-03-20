import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';
import 'package:value_renderer/value_renderer.dart';

import 'complex_item.dart';

class AddressRenderer extends StatefulWidget {
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String valueType;
  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;
  final List<String> optionalValues;
  final ValueRendererController? controller;
  final String? translatedText;
  final AttributeValue? initialValue;

  const AddressRenderer({
    required this.renderHints,
    required this.valueHints,
    required this.valueType,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
    required this.optionalValues,
    this.controller,
    this.translatedText,
    this.initialValue,
    super.key,
  });

  @override
  State<AddressRenderer> createState() => _AddressRendererState();
}

class _AddressRendererState extends State<AddressRenderer> {
  Map<String, ValueRendererController>? _controllers;
  IdentityAttribute? _attributeValue;
  List<String>? _keys;
  final Map<String, dynamic> _value = {};

  @override
  void initState() {
    super.initState();

    setState(() => _keys = _getKeysOrder(widget.valueType));

    if (widget.controller != null) {
      _controllers = <String, ValueRendererController>{};

      for (final key in widget.renderHints.propertyHints!.keys) {
        final controller = ValueRendererController();
        _controllers![key] = controller;

        controller.addListener(() {
          _value[key] = controller.value;

          if (controller.value is ValueRendererValidationError) {
            widget.controller!.value = ValueRendererValidationError();

            return;
          }

          _attributeValue = composeIdentityAttributeValue(
            isComplex: widget.renderHints.editType == RenderHintsEditType.Complex,
            currentAddress: '',
            valueType: widget.valueType,
            inputValue: ValueRendererInputValueMap(Map<String, dynamic>.from(_value)),
          );

          if (_attributeValue == null) {
            widget.controller!.value = ValueRendererValidationError();

            return;
          }

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
    return ComplexItemRenderer(
      renderHints: widget.renderHints,
      controller: widget.controller,
      optionalValues: widget.optionalValues,
      keys: _keys,
      controllers: _controllers,
      valueHints: widget.valueHints,
      valueType: widget.valueType,
      expandFileReference: widget.expandFileReference,
      chooseFile: widget.chooseFile,
      openFileDetails: widget.openFileDetails,
      translatedText: widget.translatedText,
      initialValue: widget.initialValue,
    );
  }

  List<String>? _getKeysOrder(String? valueType) {
    switch (valueType) {
      case 'StreetAddress':
        return ['recipient', 'street', 'houseNo', 'zipCode', 'city', 'state', 'country'];
      case 'PostOfficeBoxAddress':
        return ['recipient', 'boxId', 'zipCode', 'city', 'state', 'country'];
      case 'DeliveryBoxAddress':
        return ['recipient', 'deliveryBoxId', 'userId', 'phoneNumber', 'zipCode', 'city', 'state', 'country'];
    }
    return null;
  }
}
