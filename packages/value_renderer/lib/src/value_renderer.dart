import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'renderers/renderers.dart';
import 'value_renderer_controller.dart';

class ValueRenderer extends StatelessWidget {
  final InputDecoration? decoration;
  final String? fieldName;
  final AttributeValue? initialValue;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String? valueType;
  final bool mustBeFilledOut;

  final ValueRendererController? controller;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;

  const ValueRenderer({
    super.key,
    this.decoration,
    this.fieldName,
    this.initialValue,
    required this.renderHints,
    required this.valueHints,
    this.controller,
    this.valueType,
    this.mustBeFilledOut = false,
    required this.expandFileReference,
    required this.chooseFile,
  });

  @override
  Widget build(BuildContext context) {
    final technicalType = renderHints.technicalType;
    final editType = renderHints.editType;
    final dataType = renderHints.dataType;
    final values = valueHints.values;

    if (dataType == RenderHintsDataType.FileReference) {
      return FileReferenceRenderer(
        controller: controller,
        fieldName: fieldName,
        initialValue: initialValue,
        mustBeFilledOut: mustBeFilledOut,
        valueHints: valueHints,
        expandFileReference: expandFileReference,
        chooseFile: chooseFile,
      );
    }

    if (technicalType == RenderHintsTechnicalType.Integer || technicalType == RenderHintsTechnicalType.Float) {
      return NumberRenderer(
        controller: controller,
        decoration: decoration,
        editType: editType,
        dataType: dataType,
        fieldName: fieldName,
        initialValue: initialValue,
        mustBeFilledOut: mustBeFilledOut,
        technicalType: technicalType,
        values: values,
        valueHints: valueHints,
      );
    }

    if (editType == RenderHintsEditType.Complex) {
      assert(valueType != null, 'Value type must be provided for complex type');

      return ComplexRenderer(
        controller: controller,
        decoration: decoration,
        editType: editType,
        fieldName: fieldName,
        initialValue: initialValue,
        mustBeFilledOut: mustBeFilledOut,
        renderHints: renderHints,
        valueHints: valueHints,
        valueType: valueType!,
        expandFileReference: expandFileReference,
        chooseFile: chooseFile,
      );
    }

    if (technicalType == RenderHintsTechnicalType.String) {
      return StringRenderer(
        controller: controller,
        dataType: dataType,
        decoration: decoration,
        editType: editType,
        fieldName: fieldName,
        initialValue: initialValue,
        mustBeFilledOut: mustBeFilledOut,
        technicalType: technicalType,
        valueHints: valueHints,
        values: values,
      );
    }

    if (technicalType == RenderHintsTechnicalType.Boolean) {
      return BooleanRenderer(
        controller: controller,
        dataType: dataType,
        decoration: decoration,
        editType: editType,
        initialValue: initialValue,
        mustBeFilledOut: mustBeFilledOut,
        technicalType: technicalType,
        fieldName: fieldName,
        values: values,
      );
    }

    throw Exception('Cannot render combination of technical type $technicalType and edit type $editType');
  }
}
