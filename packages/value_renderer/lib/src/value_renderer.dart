import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import './widgets/renderers/renderers.dart';

class ValueRenderer extends StatelessWidget {
  final String fieldName;
  final AttributeValue? initialValue;
  final RenderHints renderHints;
  final ValueHints valueHints;

  const ValueRenderer({
    super.key,
    required this.fieldName,
    this.initialValue,
    required this.renderHints,
    required this.valueHints,
  });

  @override
  Widget build(BuildContext context) {
    final technicalType = renderHints.technicalType;
    final editType = renderHints.editType;
    final dataType = renderHints.dataType;
    final values = valueHints.values;

    if (technicalType == RenderHintsTechnicalType.Integer || technicalType == RenderHintsTechnicalType.Float) {
      return NumberRenderer(
        editType: editType,
        dataType: dataType,
        fieldName: fieldName,
        initialValue: initialValue,
        values: values,
        valueHints: valueHints,
      );
    }

    if (editType == RenderHintsEditType.Complex) {
      return ComplexRenderer(
        editType: editType,
        fieldName: fieldName,
        initialValue: initialValue,
        renderHints: renderHints,
        valueHints: valueHints,
      );
    }

    if (technicalType == RenderHintsTechnicalType.String) {
      return StringRenderer(
        dataType: dataType,
        editType: editType,
        fieldName: fieldName,
        initialValue: initialValue,
        valueHints: valueHints,
        values: values,
      );
    }

    if (technicalType == RenderHintsTechnicalType.Boolean) {
      return BooleanRenderer(
        dataType: dataType,
        editType: editType,
        initialValue: initialValue,
        fieldName: fieldName,
        values: values,
      );
    }

    throw Exception('Cannot render combination of technical type $technicalType and edit type $editType');
  }
}
