import 'package:enmeshed_types/enmeshed_types.dart';

typedef OpenAttributeScreen = Future<AbstractAttribute?> Function({
  required String valueType,
  required List<AbstractAttribute> attributes,
  ValueHints? valueHints,
});
