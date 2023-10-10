import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:translated_text/translated_text.dart';

class IdentityAttributeQueryRenderer extends StatelessWidget {
  final IdentityAttributeQueryDVO query;

  const IdentityAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TranslatedText(query.name),
        const SizedBox(height: 8),
        Text(query.valueType)
        //ValueRenderer(fieldName: query.valueType, renderHints: query.renderHints, valueHints: query.valueHints),
      ],
    );
  }
}

class RelationshipAttributeQueryRenderer extends StatelessWidget {
  final RelationshipAttributeQueryDVO query;

  const RelationshipAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(query.name),
        Text(query.attributeCreationHints.title),
        const SizedBox(height: 8),
        Text(query.valueType)
        //ValueRenderer(fieldName: query.valueType, renderHints: query.renderHints, valueHints: query.valueHints),
      ],
    );
  }
}

class ThirdPartyAttributeQueryRenderer extends StatelessWidget {
  final ThirdPartyRelationshipAttributeQueryDVO query;

  const ThirdPartyAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(query.name),
        // owner, thirdParty ...
      ],
    );
  }
}
