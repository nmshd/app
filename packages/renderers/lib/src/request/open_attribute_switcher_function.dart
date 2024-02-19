import 'package:enmeshed_types/enmeshed_types.dart';

typedef AttributeSwitcherChoice = ({String? id, AbstractAttribute attribute});

typedef OpenAttributeSwitcherFunction = Future<AttributeSwitcherChoice?> Function({
  required String valueType,
  required List<AttributeSwitcherChoice> attributes,
  ValueHints? valueHints,
});
