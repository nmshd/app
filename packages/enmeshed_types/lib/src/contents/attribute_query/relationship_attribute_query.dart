part of 'attribute_query.dart';

class RelationshipAttributeCreationHints {
  final String title;
  final String valueType;
  final String? description;
  final ValueHints? valueHints;
  final String confidentiality;

  RelationshipAttributeCreationHints({
    required this.title,
    required this.valueType,
    this.description,
    this.valueHints,
    required this.confidentiality,
  });

  factory RelationshipAttributeCreationHints.fromJson(Map<String, dynamic> json) => RelationshipAttributeCreationHints(
        title: json['title'],
        valueType: json['valueType'],
        description: json['description'],
        valueHints: json['valueHints'] != null ? ValueHints.fromJson(json['valueHints']) : null,
        confidentiality: json['confidentiality'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'valueType': valueType,
        if (description != null) 'description': description,
        if (valueHints != null) 'valueHints': valueHints,
        'confidentiality': confidentiality,
      };

  @override
  String toString() {
    return 'RelationshipAttributeCreationHints(title: $title, valueType: $valueType, description: $description, valueHints: $valueHints, confidentiality: $confidentiality)';
  }
}

class RelationshipAttributeQuery extends AttributeQuery {
  final String key;
  final String owner;
  final RelationshipAttributeCreationHints attributeCreationHints;

  RelationshipAttributeQuery({
    required this.key,
    required this.owner,
    required this.attributeCreationHints,
  });

  factory RelationshipAttributeQuery.fromJson(Map<String, dynamic> json) => RelationshipAttributeQuery(
        key: json['key'],
        owner: json['owner'],
        attributeCreationHints: RelationshipAttributeCreationHints.fromJson(json['attributeCreationHints']),
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'RelationshipAttributeQuery',
        'key': key,
        'owner': owner,
        'attributeCreationHints': attributeCreationHints.toJson(),
      };

  @override
  String toString() => 'RelationshipAttributeQuery(key: $key, owner: $owner, attributeCreationHints: $attributeCreationHints)';
}
