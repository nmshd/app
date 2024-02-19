import 'package:enmeshed_types/enmeshed_types.dart';

typedef OpenSelectAttributeScreenFunction = Future<AbstractAttribute?> Function({
  required String valueType,
  required List<AbstractAttribute> attributes,
  ValueHints? valueHints,
});
