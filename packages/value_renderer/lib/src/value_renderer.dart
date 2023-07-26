import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/renderers/boolean.dart';
import 'package:value_renderer/src/widgets/renderers/complex.dart';
import 'package:value_renderer/src/widgets/renderers/number.dart';
import 'package:value_renderer/src/widgets/renderers/string.dart';
import 'package:value_renderer/value_renderer.dart';

class ValueRenderer extends StatelessWidget {
  const ValueRenderer({
    super.key,
    this.initialValue,
    this.fieldName,
    required this.renderHints,
    required this.valueHints,
  });

  final Map<String, dynamic>? initialValue;
  final Map<String, dynamic> renderHints;
  final Map<String, dynamic> valueHints;
  final String? fieldName;

  @override
  Widget build(BuildContext context) {
    final RenderHintsTechnicalType technicalType = parseTechnicalType(renderHints['technicalType']);
    final RenderHintsEditType editType = parseEditType(renderHints['editType']);
    final RenderHintsDataType dataType = parseDataType(renderHints['dataType'] ?? '');
    final List<dynamic>? values = valueHints['values'] ?? [];

    if (technicalType == RenderHintsTechnicalType.Integer ||
        technicalType == RenderHintsTechnicalType.Float ||
        initialValue?['@type'] == 'BirthDate') {
      return NumberRenderer(
        initialValue: initialValue,
        fieldName: fieldName,
        editType: editType,
        dataType: dataType,
        values: values,
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
        initialValue: initialValue?['value'] ?? '',
        fieldName: fieldName,
        editType: editType,
        dataType: dataType,
        values: values,
      );
    }
    if (technicalType == RenderHintsTechnicalType.Boolean) {
      return BooleanRenderer(
        initialValue: initialValue?['value'] ?? '',
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
