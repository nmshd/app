import 'package:enmeshed_types/enmeshed_types.dart';

typedef AttributeSwitcherChoice = ({LocalAttributeDVO? dvo, AbstractAttribute attribute});

typedef OpenAttributeSwitcherFunction =
    Future<AttributeSwitcherChoice?> Function({
      required String? valueType,
      required List<AttributeSwitcherChoice> choices,
      required AttributeSwitcherChoice? currentChoice,
      ValueHints? valueHints,
    });

typedef CreateAttributeFunction = Future<AttributeSwitcherChoice?> Function({required String valueType, ValueHints? valueHints});
