import 'package:enmeshed_types/enmeshed_types.dart';

typedef AttributeSwitcherChoice = ({LocalAttributeDVO? dvo, AbstractAttribute attribute});

typedef OpenAttributeSwitcherFunction =
    Future<AttributeSwitcherChoice?> Function({
      required String? valueType,
      required List<AttributeSwitcherChoice> choices,
      required AttributeSwitcherChoice? currentChoice,
      ValueHints? valueHints,
    });

typedef CreateIdentityAttributeFunction =
    Future<({LocalAttributeDVO dvo, IdentityAttribute attribute})?> Function({required String valueType, ValueHints? valueHints});

typedef ComposeRelationshipAttributeFunction = Future<RelationshipAttribute?> Function({required ProcessedRelationshipAttributeQueryDVO query});
