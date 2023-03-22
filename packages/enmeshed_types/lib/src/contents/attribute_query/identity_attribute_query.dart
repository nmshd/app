part of 'attribute_query.dart';

class IdentityAttributeQuery extends AttributeQuery {
  final String valueType;
  final List<String>? tags;

  const IdentityAttributeQuery({
    required this.valueType,
    this.tags,
    super.validFrom,
    super.validTo,
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
      ...super.toJson(),
      '@type': 'IdentityAttributeQuery',
      'valueType': valueType,
      if (tags != null) 'tags': tags,
    };
  }

  @override
  String toString() => 'IdentityAttributeQuery(valueType: $valueType, tags: $tags)';

  @override
  List<Object?> get props => [
        super.props,
        valueType,
        tags,
      ];
}
