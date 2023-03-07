part of 'abstract_attribute.dart';

class IdentityAttribute extends AbstractAttribute {
  final List<String>? tags;

  IdentityAttribute({
    required super.owner,
    super.validFrom,
    super.validTo,
    required super.value,
    this.tags,
  });

  @override
  String toString() {
    return 'IdentityAttribute(owner: $owner, validFrom: $validFrom, validTo: $validTo, value: $value, tags: $tags)';
  }

  factory IdentityAttribute.fromJson(Map<String, dynamic> json) => IdentityAttribute(
        owner: json['owner'],
        validFrom: json['validFrom'],
        validTo: json['validTo'],
        value: json['value'],
        tags: json['tags'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'IdentityAttribute',
        if (tags != null) 'tags': tags,
      };
}
