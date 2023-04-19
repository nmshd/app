part of 'attribute_query.dart';

class RelationshipAttributeCreationHints extends Equatable {
  final String title;
  final String valueType;
  final String? description;
  final ValueHints? valueHints;
  final String confidentiality;

  const RelationshipAttributeCreationHints({
    required this.title,
    required this.valueType,
    this.description,
    this.valueHints,
    required this.confidentiality,
  });

  factory RelationshipAttributeCreationHints.fromJson(Map json) => RelationshipAttributeCreationHints(
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

  @override
  List<Object?> get props => [
        title,
        valueType,
        description,
        valueHints,
        confidentiality,
      ];
}
