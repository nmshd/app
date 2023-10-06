import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:value_renderer/value_renderer.dart';

class ProcessedIdentityAttributeQueryRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;

  const ProcessedIdentityAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(query.id),
        Text(query.name),
        if (query.description != null) Text(query.description!),
        if (query.image != null) Text(query.image!),
        Text(query.type),
        if (query.date != null) Text(query.date!),
        if (query.error != null) Text(query.error!.code),
        if (query.error != null && query.error!.message != null) Text(query.error!.message!),
        if (query.warning != null) Text(query.warning!.code),
        if (query.warning != null && query.warning!.message != null) Text(query.warning!.message!),
        if (query.validFrom != null) Text(query.validFrom!),
        if (query.validTo != null) Text(query.validTo!),
        //Text(query.results.first.type), // TODO: add other results
        Text(query.tags.toString()),
        Text(query.valueType),
        Text(query.isProcessed.toString()),
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
        Text(query.id),
        Text(query.name),
        if (query.description != null) Text(query.description!),
        if (query.image != null) Text(query.image!),
        Text(query.type),
        if (query.date != null) Text(query.date!),
        if (query.error != null) Text(query.error!.code),
        if (query.error != null && query.error!.message != null) Text(query.error!.message!),
        if (query.warning != null) Text(query.warning!.code),
        if (query.warning != null && query.warning!.message != null) Text(query.warning!.message!),
        if (query.validFrom != null) Text(query.validFrom!),
        if (query.validTo != null) Text(query.validTo!),
        // Text(query.valueType),
        Text(query.key),
        Text(query.owner.name),
        Text(query.isProcessed.toString()),
        Text(query.attributeCreationHints.title),
        // ValueRenderer(fieldName: query.valueType, renderHints: query.renderHints, valueHints: query.valueHints),
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
        Text(query.name),
        Text(query.id),
        // owner, thirdParty ...
      ],
    );
  }
}
