import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

class IdentityAttributeQueryRenderer extends StatelessWidget {
  final IdentityAttributeQueryDVO query;

  const IdentityAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(query.type),
        Text(query.valueType),
        Text(query.name),
        Text(query.id),
      ],
    );
  }
}

class RelationshiAttributeQueryRenderer extends StatelessWidget {
  final RelationshipAttributeQueryDVO query;

  const RelationshiAttributeQueryRenderer({super.key, required this.query});

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
    return switch (query.type) {
      'IdentityAttributeQueryDVO' => IdentityAttributeQueryRenderer(query: query as IdentityAttributeQueryDVO),
      'RelationshipAttributeQueryDVO' => RelationshiAttributeQueryRenderer(query: query as RelationshipAttributeQueryDVO),
      'ThirdPartyRelationshipAttributeQueryDVO' => ThirdPartyAttributeQueryRenderer(query: query as ThirdPartyRelationshipAttributeQueryDVO),
      _ => throw Exception("Invalid type '${query.type}'"),
    };
  }
}
