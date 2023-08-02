import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/renderers/boolean.dart';
import 'package:value_renderer/src/widgets/renderers/complex.dart';
import 'package:value_renderer/src/widgets/renderers/number.dart';
import 'package:value_renderer/src/widgets/renderers/string.dart';

class ValueRenderer extends StatelessWidget {
  const ValueRenderer({
    super.key,
    this.initialValue,
    this.fieldName,
    required this.renderHints,
    required this.valueHints,
  });

  final Map<String, dynamic>? initialValue;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String? fieldName;

  @override
  Widget build(BuildContext context) {
    final technicalType = renderHints.technicalType;
    final editType = renderHints.editType;
    final dataType = renderHints.dataType;
    final values = valueHints.values;

    if (technicalType == RenderHintsTechnicalType.Integer ||
        technicalType == RenderHintsTechnicalType.Float ||
        initialValue?['@type'] == 'BirthDate') {
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
        values: values,
        valueHints: valueHints,
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
