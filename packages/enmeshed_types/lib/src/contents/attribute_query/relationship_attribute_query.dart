part of 'attribute_query.dart';

class RelationshipAttributeQuery extends AttributeQuery {
  final String key;
  final String owner;
  final RelationshipAttributeCreationHints attributeCreationHints;

  const RelationshipAttributeQuery({
    required this.key,
    required this.owner,
    required this.attributeCreationHints,
    super.validFrom,
    super.validTo,
  });

  factory RelationshipAttributeQuery.fromJson(Map<String, dynamic> json) => RelationshipAttributeQuery(
        key: json['key'],
        owner: json['owner'],
        attributeCreationHints: RelationshipAttributeCreationHints.fromJson(json['attributeCreationHints']),
        validFrom: json['validFrom'],
        validTo: json['validTo'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'RelationshipAttributeQuery',
        'key': key,
        'owner': owner,
        'attributeCreationHints': attributeCreationHints.toJson(),
      };

  @override
  String toString() => 'RelationshipAttributeQuery(key: $key, owner: $owner, attributeCreationHints: $attributeCreationHints)';

  @override
  List<Object?> get props => [
        super.props,
        key,
        owner,
        attributeCreationHints,
      ];
}
