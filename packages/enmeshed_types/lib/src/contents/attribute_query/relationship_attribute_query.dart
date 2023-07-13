part of 'attribute_query.dart';

@JsonSerializable(includeIfNull: false)
class RelationshipAttributeQuery extends AttributeQuery {
  final String key;
  final String owner;
  final RelationshipAttributeCreationHints attributeCreationHints;
  final String? validFrom;
  final String? validTo;

  const RelationshipAttributeQuery({
    required this.key,
    required this.owner,
    required this.attributeCreationHints,
    this.validFrom,
    this.validTo,
  });

  factory RelationshipAttributeQuery.fromJson(Map json) => _$RelationshipAttributeQueryFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => {'@type': 'RelationshipAttributeQuery', ..._$RelationshipAttributeQueryToJson(this)};

  @override
  List<Object?> get props => [
        super.props,
        key,
        owner,
        attributeCreationHints,
      ];
}
