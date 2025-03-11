part of 'attribute_query.dart';

enum ThirdPartyRelationshipAttributeQueryOwner {
  @JsonValue('thirdParty')
  thirdParty,
  @JsonValue('recipient')
  recipient,
  @JsonValue('')
  empty,
}

@JsonSerializable(includeIfNull: false)
class ThirdPartyRelationshipAttributeQuery extends AttributeQuery {
  final String key;
  final ThirdPartyRelationshipAttributeQueryOwner owner;
  final List<String> thirdParty;

  const ThirdPartyRelationshipAttributeQuery({required this.key, required this.owner, required this.thirdParty});

  factory ThirdPartyRelationshipAttributeQuery.fromJson(Map json) => _$ThirdPartyRelationshipAttributeQueryFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => {'@type': 'ThirdPartyRelationshipAttributeQuery', ..._$ThirdPartyRelationshipAttributeQueryToJson(this)};

  @override
  List<Object?> get props => [super.props, key, owner, thirdParty];
}
