import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/widgets/renderers/boolean.dart';
import 'package:value_renderer/src/widgets/renderers/number.dart';
import 'package:value_renderer/src/widgets/renderers/string.dart';

class ValueRenderer extends StatelessWidget {
  const ValueRenderer({
    super.key,
    this.fieldName,
    this.technicalType,
    this.editType,
    this.dataType,
    this.valueHintsValue,
  });

  final String? fieldName;
  final RenderHintsTechnicalType? technicalType;
  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final bool? valueHintsValue;

  @override
  Widget build(BuildContext context) {
    if (technicalType == RenderHintsTechnicalType.String) {
      return StringRenderer(
        fieldName: fieldName,
        editType: editType,
        dataType: dataType,
      );
    }
    if (technicalType == RenderHintsTechnicalType.Boolean) {
      return BooleanRenderer(
        fieldName: fieldName,
        editType: editType,
        dataType: dataType,
        valueHintsValue: valueHintsValue,
      );
    }
    if (technicalType == RenderHintsTechnicalType.Integer || technicalType == RenderHintsTechnicalType.Float) {
      return NumberRenderer(
        fieldName: fieldName,
        editType: editType,
        dataType: dataType,
        valueHintsValue: valueHintsValue,
      );
    } else {
      return const StringRenderer();
    }
  }
}
