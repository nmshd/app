part of 'attribute_query.dart';

class IdentityAttributeQuery extends AttributeQuery {
  final String valueType;
  final List<String>? tags;

  IdentityAttributeQuery({
    required this.valueType,
    this.tags,
  });

  factory IdentityAttributeQuery.fromJson(Map<String, dynamic> json) {
    return IdentityAttributeQuery(
      valueType: json['valueType'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '@type': 'IdentityAttributeQuery',
      'valueType': valueType,
      if (tags != null) 'tags': tags,
    };
  }

  @override
  String toString() => 'IdentityAttributeQuery(valueType: $valueType, tags: $tags)';
}
