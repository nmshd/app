import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:value_renderer/value_renderer.dart';

class IdentityAttributeQueryRenderer extends StatelessWidget {
  final IdentityAttributeQueryDVO query;

  const IdentityAttributeQueryRenderer({super.key, required this.query});

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
        Text(query.valueType),
        if (query.tags != null) Text(query.tags!.toString()),
        Text(query.isProcessed.toString()),
        ValueRenderer(fieldName: query.name, renderHints: query.renderHints, valueHints: query.valueHints),
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
        Text(query.type),
        Text(query.valueType),
        Text(query.name),
        Text(query.id),
        // renderHints, valueHints ...
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
        Text(query.type),
        Text(query.name),
        Text(query.id),
        // owner, thirdParty ...
      ],
    );
  }
}

class QueryRenderer {
  static Widget render({required AttributeQueryDVO query}) {
    return switch (query) {
      final IdentityAttributeQueryDVO query => IdentityAttributeQueryRenderer(query: query),
      final RelationshipAttributeQueryDVO query => RelationshipAttributeQueryRenderer(query: query),
      final ThirdPartyRelationshipAttributeQueryDVO query => ThirdPartyAttributeQueryRenderer(query: query),
      _ => throw Exception("Invalid type '${query.type}'"),
    };
  }
}
