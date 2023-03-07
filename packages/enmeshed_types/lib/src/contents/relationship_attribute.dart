import 'abstract_attribute.dart';
import 'attribute_values/attribute_values.dart';

enum RelationshipAttributeConfidentiality { public, private, protected }

class RelationshipAttribute extends AbstractAttribute {
  final RelationshipAttributeValue value;
  final String key;
  final bool? isTechnical;
  final RelationshipAttributeConfidentiality confidentiality;

  RelationshipAttribute({
    required super.owner,
    super.validFrom,
    super.validTo,
    required this.value,
    required this.key,
    this.isTechnical,
    required this.confidentiality,
  });

  @override
  String toString() {
    return 'RelationshipAttribute(owner: $owner, validFrom: $validFrom, validTo: $validTo, value: $value, key: $key, isTechnical: $isTechnical, confidentiality: $confidentiality)';
  }

  factory RelationshipAttribute.fromJson(Map<String, dynamic> json) => RelationshipAttribute(
        owner: json['owner'],
        validFrom: json['validFrom'],
        validTo: json['validTo'],
        value: RelationshipAttributeValue.fromJson(json['value']),
        key: json['key'],
        isTechnical: json['isTechnical'],
        confidentiality: RelationshipAttributeConfidentiality.values.byName(json['confidentiality']),
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'RelationshipAttribute',
        'value': value.toJson(),
        'key': key,
        if (isTechnical != null) 'isTechnical': isTechnical,
        'confidentiality': confidentiality.name,
      };
}
