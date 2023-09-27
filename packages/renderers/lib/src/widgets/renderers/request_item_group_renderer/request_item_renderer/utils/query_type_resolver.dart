import 'package:enmeshed_types/enmeshed_types.dart';

class QueryTypeResolver {
  static AttributeQueryDVO resolveType({required AttributeQueryDVO query}) {
    return switch (query.type) {
      'IdentityAttributeQueryDVO' => query as IdentityAttributeQueryDVO,
      'RelationshipAttributeQueryDVO' => query as RelationshipAttributeQueryDVO,
      'ThirdPartyRelationshipAttributeQueryDVO' => query as ThirdPartyRelationshipAttributeQueryDVO,
      'IQLQueryDVO' => query as IQLQueryDVO,
      _ => throw Exception("Invalid type '${query.type}'"),
    };
  }
}
