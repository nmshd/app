part of 'attribute_query.dart';

class IdentityAttributeQuery extends AttributeQuery {
  final String valueType;
  final List<String>? tags;
  final String? validFrom;
  final String? validTo;

  IdentityAttributeQuery({
    required this.valueType,
    this.tags,
    this.validFrom,
    this.validTo,
  });

  factory IdentityAttributeQuery.fromJson(Map<String, dynamic> json) {
    return IdentityAttributeQuery(
      valueType: json['valueType'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      validFrom: json['validFrom'],
      validTo: json['validTo'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '@type': 'IdentityAttributeQuery',
      'valueType': valueType,
      if (tags != null) 'tags': tags,
      if (validFrom != null) 'validFrom': validFrom,
      if (validTo != null) 'validTo': validTo,
    };
  }

  @override
  String toString() => 'IdentityAttributeQuery(valueType: $valueType, tags: $tags)';
}
