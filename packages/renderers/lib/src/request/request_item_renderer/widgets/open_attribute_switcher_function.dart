import 'package:enmeshed_types/enmeshed_types.dart';

typedef OpenAttributeSwitcherFunction = Future<AbstractAttribute?> Function({
  required String valueType,
  required List<AbstractAttribute> attributes,
  ValueHints? valueHints,
});
