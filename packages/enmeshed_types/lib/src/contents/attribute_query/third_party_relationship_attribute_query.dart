part of 'attribute_query.dart';

enum ThirdPartyRelationshipAttributeQueryOwner { thirdParty, recipient, empty }

class ThirdPartyRelationshipAttributeQuery extends AttributeQuery {
  final String key;
  final ThirdPartyRelationshipAttributeQueryOwner owner;
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

  factory ThirdPartyRelationshipAttributeQuery.fromJson(Map json) {
    return ThirdPartyRelationshipAttributeQuery(
      key: json['key'],
      owner: json['owner'] == ''
          ? ThirdPartyRelationshipAttributeQueryOwner.empty
          : ThirdPartyRelationshipAttributeQueryOwner.values.byName(json['owner']),
      thirdParty: (json['thirdParty'] as List<dynamic>).map((e) => e as String).toList(),
      validFrom: json['validTo'],
      validTo: json['validTo'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      '@type': 'ThirdPartyRelationshipAttributeQuery',
      'key': key,
      'owner': owner == ThirdPartyRelationshipAttributeQueryOwner.empty ? '' : owner.name,
      'thirdParty': thirdParty,
      'validFrom': validFrom,
      'validTo': validTo,
    };

    json.removeWhere((key, value) => value == null);
    return json;
  }

  @override
  List<Object?> get props => [
        super.props,
        key,
        owner,
        thirdParty,
      ];
}
