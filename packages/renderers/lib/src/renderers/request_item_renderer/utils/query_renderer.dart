import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

class IdentityAttributeQueryRenderer extends StatelessWidget {
  final IdentityAttributeQueryDVO query;

  const IdentityAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(query.id),
          Text(query.name),
          Text(query.description ?? ''),
          Text(query.image ?? ''),
          Text(query.type),
          Text(query.date ?? ''),
          Text(query.error?.code ?? ''),
          Text(query.error?.message ?? ''),
          Text(query.warning?.code ?? ''),
          Text(query.warning?.message ?? ''),
          Text(query.validFrom ?? ''),
          Text(query.validTo ?? ''),
          Text(query.valueType),
          Text(query.tags?.toString() ?? ''),
          Text(query.isProcessed.toString()),
          Text(query.renderHints.toString()),
          Text(query.valueHints.toString()),
        ],
      ),
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
