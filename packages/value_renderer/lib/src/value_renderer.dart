import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import './widgets/renderers/renderers.dart';

class ValueRenderer extends StatelessWidget {
  final Map<String, dynamic>? initialValue;
  final RenderHints renderHints;
  final ValueHints valueHints;

  const ValueRenderer({
    super.key,
    this.initialValue,
    required this.renderHints,
    required this.valueHints,
  });

  @override
  Widget build(BuildContext context) {
    final technicalType = renderHints.technicalType;
    final editType = renderHints.editType;
    final dataType = renderHints.dataType;
    final fieldName = initialValue?['@type'] ?? '';
    final values = valueHints.values ?? [];

    if (technicalType == RenderHintsTechnicalType.Integer || technicalType == RenderHintsTechnicalType.Float) {
      return NumberRenderer(
        initialValue: initialValue,
        fieldName: fieldName,
        editType: editType,
        dataType: dataType,
        values: values,
        valueHints: valueHints,
      );
    }

    if (editType == RenderHintsEditType.Complex) {
      return ComplexRenderer(
        initialValue: initialValue ?? {},
        fieldName: fieldName,
        editType: editType,
        renderHints: renderHints,
        valueHints: valueHints,
      );
    }

    if (technicalType == RenderHintsTechnicalType.String) {
      return StringRenderer(
        initialValue: initialValue ?? {},
        fieldName: fieldName,
        editType: editType,
        dataType: dataType,
        valueHints: valueHints,
        values: values,
      );
    }

    if (technicalType == RenderHintsTechnicalType.Boolean) {
      return BooleanRenderer(
        initialValue: initialValue,
        fieldName: fieldName,
        editType: editType,
        dataType: dataType,
        values: values,
      );
    } else {
      return const Text('No value provided');
    }
  }
}
