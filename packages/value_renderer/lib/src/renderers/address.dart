import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';
import 'package:value_renderer/src/renderers/complex.dart';
import 'package:value_renderer/value_renderer.dart';

class AddressRenderer extends StatefulWidget {
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String valueType;
  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;
  final ValueRendererController? controller;
  final String? translatedText;
  final AttributeValue? initialValue;

  const AddressRenderer({
    super.key,
    required this.renderHints,
    required this.valueHints,
    required this.valueType,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
    this.controller,
    this.translatedText,
    this.initialValue,
  });

  @override
  State<AddressRenderer> createState() => _AddressRendererState();
}

class _AddressRendererState extends State<AddressRenderer> {
  Map<String, ValueRendererController>? _controllers;
  IdentityAttribute? _attributeValue;

  final Map<String, dynamic> _value = {};

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

          if (controller.value is ValueRendererValidationError) return;

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
      controllers: _controllers,
      valueHints: widget.valueHints,
      valueType: widget.valueType,
      expandFileReference: widget.expandFileReference,
      chooseFile: widget.chooseFile,
      openFileDetails: widget.openFileDetails,
    );
  }
}
