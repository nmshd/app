import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

extension ToValueHintsDefaultValueString on String? {
  ValueHintsDefaultValueString? toValueHintsDefaultValue() => this == null ? null : ValueHintsDefaultValueString(this!);
}

extension FieldName on BuildContext {
  String? translateFieldName(String? fieldName, bool isRequired) {
    if (fieldName == null) return null;
    
    final translatedFieldName = fieldName.startsWith('i18n://') ? FlutterI18n.translate(this, fieldName.substring(7)) : fieldName;
    if (isRequired && !translatedFieldName.contains('*')) return '$translatedFieldName*';
    return translatedFieldName;
  }
}
