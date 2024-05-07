import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

extension FieldName on BuildContext {
  String? translateFieldName(String? fieldName, bool isRequired) {
    if (fieldName == null) return null;

    final translatedFieldName = fieldName.startsWith('i18n://') ? FlutterI18n.translate(this, fieldName.substring(7)) : fieldName;
    if (isRequired) return '$translatedFieldName*';
    return translatedFieldName;
  }
}
