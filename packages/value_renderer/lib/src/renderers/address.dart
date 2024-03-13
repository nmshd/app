import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';
import 'package:value_renderer/src/renderers/complex.dart';
import 'package:value_renderer/value_renderer.dart';

class AddressRenderer extends StatefulWidget {
  final ValueRendererController? controller;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String valueType;
  final String? translatedText;
  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

  const AddressRenderer(
      {super.key,
      this.controller,
      this.translatedText,
      required this.renderHints,
      required this.valueHints,
      required this.expandFileReference,
      required this.chooseFile,
      required this.openFileDetails,
      required this.valueType});

  @override
  State<AddressRenderer> createState() => _AddressRendererState();
}

class _AddressRendererState extends State<AddressRenderer> {
  final Map<String, dynamic> _value = {};
  Map<String, ValueRendererController>? controllers;
  IdentityAttribute? _attributeValue;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      controllers = <String, ValueRendererController>{};

      for (final key in widget.renderHints.propertyHints!.keys) {
        final controller = ValueRendererController();
        controllers![key] = controller;

        controller.addListener(() {
          _value[key] = controller.value;

          if (_value[key] is ValueRendererValidationError) {
            widget.controller!.value = ValueRendererValidationError();
            return;
          }

          widget.controller!.value = ValueRendererInputValueMap(Map<String, dynamic>.from(_value));
        });
      }

      widget.controller?.addListener(() {
        _validate();
      });
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

  void _validate() {
    if (widget.controller?.value is ValueRendererValidationError) return;

    _attributeValue = composeIdentityAttributeValue(
      isComplex: widget.renderHints.editType == RenderHintsEditType.Complex,
      currentAddress: '',
      valueType: widget.valueType,
      inputValue: widget.controller!.value,
    );

    if (_attributeValue != null) return;

    widget.controller!.value = ValueRendererValidationError();
  }

  @override
  Widget build(BuildContext context) {
    return ComplexItemRenderer(
      renderHints: widget.renderHints,
      controller: widget.controller,
      controllers: controllers,
      valueHints: widget.valueHints,
      valueType: widget.valueType,
      expandFileReference: widget.expandFileReference,
      chooseFile: widget.chooseFile,
      openFileDetails: widget.openFileDetails,
    );
  }
}
