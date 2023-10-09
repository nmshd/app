import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:translated_text/translated_text.dart';
import 'package:value_renderer/value_renderer.dart';

class ProcessedIdentityAttributeQueryRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;

  const ProcessedIdentityAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TranslatedText(query.name),
        Text(query.type),
        if (query.error != null) Text(query.error!.code),
        if (query.error != null && query.error!.message != null) Text(query.error!.message!),
        if (query.warning != null) Text(query.warning!.code),
        if (query.warning != null && query.warning!.message != null) Text(query.warning!.message!),
        //Text(query.results.first.type), // TODO: add other results
        if (query.tags != null && query.tags!.isNotEmpty) Text(query.tags.toString()),
        ValueRenderer(fieldName: query.valueType, renderHints: query.renderHints, valueHints: query.valueHints),
      ],
    );
  }
}

class ProcessedRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedRelationshipAttributeQueryDVO query;

  const ProcessedRelationshipAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TranslatedText(query.name),
        Text(query.type),
        if (query.error != null) Text(query.error!.code),
        if (query.error != null && query.error!.message != null) Text(query.error!.message!),
        if (query.warning != null) Text(query.warning!.code),
        if (query.warning != null && query.warning!.message != null) Text(query.warning!.message!),
        // Text(query.valueType),
        Text(query.owner.name),
        Text(query.attributeCreationHints.title),
        //ValueRenderer(fieldName: query.valueType, renderHints: query.renderHints, valueHints: query.valueHints),
      ],
    );
  }
}

class ProcessedThirdPartyAttributeQueryRenderer extends StatelessWidget {
  final ProcessedThirdPartyRelationshipAttributeQueryDVO query;

  const ProcessedThirdPartyAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(query.type),
        TranslatedText(query.name),
        // owner, thirdParty ...
      ],
    );
  }
}
