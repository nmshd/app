import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

extension ToValueHintsDefaultValueString on String? {
  ValueHintsDefaultValueString? toValueHintsDefaultValue() => this == null ? null : ValueHintsDefaultValueString(this!);
}

extension FieldName on BuildContext {
  String fieldName(String valueType, String key, List<String> requiredValues) {
    final translation = FlutterI18n.translate(this, 'attributes.values.$valueType.$key.label');

    return requiredValues.contains(key) ? '$translation*' : translation;
  }
}
