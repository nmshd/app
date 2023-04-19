part of 'attribute_query.dart';

class ThirdPartyRelationshipAttributeQuery extends AttributeQuery {
  final String key;
  final String owner;
  final List<String> thirdParty;

  const ThirdPartyRelationshipAttributeQuery({
    required this.key,
    required this.owner,
    required this.thirdParty,
    super.validFrom,
    super.validTo,
  });

  factory ThirdPartyRelationshipAttributeQuery.fromJson(Map json) => ThirdPartyRelationshipAttributeQuery(
        key: json['key'],
        owner: json['owner'],
        thirdParty: List<String>.from(json['thirdParty']),
        validFrom: json['validFrom'],
        validTo: json['validTo'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ThirdPartyRelationshipAttributeQuery',
        'key': key,
        'owner': owner,
        'thirdParty': thirdParty,
      };

  @override
  String toString() => 'ThirdPartyRelationshipAttributeQuery(key: $key, owner: $owner, thirdParty: $thirdParty)';

  @override
  List<Object?> get props => [
        super.props,
        key,
        owner,
        thirdParty,
      ];
}
