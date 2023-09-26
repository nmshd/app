import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import './widgets/renderers/renderers.dart';

class ValueRendererController extends ValueNotifier<dynamic> {
  ValueRendererController() : super(null);
}

class ValueRenderer extends StatelessWidget {
  final InputDecoration? decoration;
  final String fieldName;
  final AttributeValue? initialValue;
  final RenderHints renderHints;
  final ValueHints valueHints;

  final ValueRendererController? controller;

  const ValueRenderer({
    super.key,
    this.decoration,
    required this.fieldName,
    this.initialValue,
    required this.renderHints,
    required this.valueHints,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final technicalType = renderHints.technicalType;
    final editType = renderHints.editType;
    final dataType = renderHints.dataType;
    final values = valueHints.values;

    if (technicalType == RenderHintsTechnicalType.Integer || technicalType == RenderHintsTechnicalType.Float) {
      return NumberRenderer(
        controller: controller,
        editType: editType,
        dataType: dataType,
        fieldName: fieldName,
        initialValue: initialValue,
        technicalType: technicalType,
        values: values,
        valueHints: valueHints,
      );
    }

    if (editType == RenderHintsEditType.Complex) {
      return ComplexRenderer(
        controller: controller,
        editType: editType,
        fieldName: fieldName,
        initialValue: initialValue,
        renderHints: renderHints,
        valueHints: valueHints,
      );
    }

    if (technicalType == RenderHintsTechnicalType.String) {
      return StringRenderer(
        controller: controller,
        dataType: dataType,
        editType: editType,
        fieldName: fieldName,
        initialValue: initialValue,
        technicalType: technicalType,
        valueHints: valueHints,
        values: values,
      );
    }

    if (technicalType == RenderHintsTechnicalType.Boolean) {
      return BooleanRenderer(
        controller: controller,
        dataType: dataType,
        editType: editType,
        initialValue: initialValue,
        technicalType: technicalType,
        fieldName: fieldName,
        values: values,
      );
    }

    throw Exception('Cannot render combination of technical type $technicalType and edit type $editType');
  }
}
