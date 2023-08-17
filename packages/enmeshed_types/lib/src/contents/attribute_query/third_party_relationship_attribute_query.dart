part of 'attribute_query.dart';

@JsonSerializable(includeIfNull: false)
class ThirdPartyRelationshipAttributeQuery extends AttributeQuery {
  final String key;
  final String owner;
  final List<String> thirdParty;
  final String? validFrom;
  final String? validTo;

  const ThirdPartyRelationshipAttributeQuery({
    required this.key,
    required this.owner,
    required this.thirdParty,
    this.validFrom,
    this.validTo,
  });

  factory ThirdPartyRelationshipAttributeQuery.fromJson(Map json) => _$ThirdPartyRelationshipAttributeQueryFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => {'@type': 'ThirdPartyRelationshipAttributeQuery', ..._$ThirdPartyRelationshipAttributeQueryToJson(this)};

  @override
  List<Object?> get props => [
        super.props,
        key,
        owner,
        thirdParty,
      ];
}
