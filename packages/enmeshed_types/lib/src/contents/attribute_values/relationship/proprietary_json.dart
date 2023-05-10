import 'relationship_attribute_value.dart';

class ProprietaryJSONAttributeValue extends RelationshipAttributeValue {
  final String title;
  final String? description;
  final Map<String, dynamic> value;

  const ProprietaryJSONAttributeValue({
    required this.title,
    this.description,
    required this.value,
  });

  factory ProprietaryJSONAttributeValue.fromJson(Map json) => ProprietaryJSONAttributeValue(
        title: json['title'],
        description: json['description'],
        value: Map<String, dynamic>.from(json['value']),
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'ProprietaryJSON',
        'title': title,
        if (description != null) 'description': description,
        'value': value,
      };

  @override
  String toString() => 'ProprietaryJSONAttributeValue(title: $title, description: $description, value: $value)';

  @override
  List<Object?> get props => [title, description, value];
}
