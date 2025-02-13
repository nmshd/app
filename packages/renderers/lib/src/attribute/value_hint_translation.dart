import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';

extension Translation on ValueHints {
  String getTranslation(dynamic value) {
    if (values == null) return value;
    final valueHint = values!.firstWhereOrNull((valueHint) => valueHint.key.toJson() == value);

    if (valueHint == null) return value;
    return valueHint.displayName;
  }
}
