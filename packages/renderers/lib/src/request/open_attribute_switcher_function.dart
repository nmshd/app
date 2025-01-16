import 'package:enmeshed_types/enmeshed_types.dart';

typedef AttributeSwitcherChoice = ({String? id, AbstractAttribute attribute, bool? isDefaultRepositoryAttribute});

typedef OpenAttributeSwitcherFunction = Future<AttributeSwitcherChoice?> Function({
  required String? valueType,
  required List<AttributeSwitcherChoice> choices,
  required AttributeSwitcherChoice? currentChoice,
  ValueHints? valueHints,
});
