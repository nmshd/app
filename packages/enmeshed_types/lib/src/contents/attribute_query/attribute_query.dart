import '../value_hints.dart';

part 'identity_attribute_query.dart';
part 'relationship_attribute_query.dart';
part 'third_party_relationship_attribute_query.dart';

abstract class AttributeQuery {
  AttributeQuery();

  factory AttributeQuery.fromJson(Map<String, dynamic> json) {
    final type = json['@type'];

    switch (type) {
      case 'IdentityAttributeQuery':
        return IdentityAttributeQuery.fromJson(json);
      case 'ThirdPartyRelationshipAttributeQuery':
        return ThirdPartyRelationshipAttributeQuery.fromJson(json);
      case 'RelationshipAttributeQuery':
        return RelationshipAttributeQuery.fromJson(json);
      default:
        throw Exception('Unknown type: $type');
    }
  }

  Map<String, dynamic> toJson();
}
