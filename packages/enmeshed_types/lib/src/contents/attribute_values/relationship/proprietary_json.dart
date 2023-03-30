import 'relationship_attribute_value.dart';

class ProprietaryJSON extends RelationshipAttributeValue {
  final String title;
  final String? description;
  final Map<String, dynamic> value;

  const ProprietaryJSON({
    required this.title,
    this.description,
    required this.value,
  });

  factory ProprietaryJSON.fromJson(Map<String, dynamic> json) => ProprietaryJSON(
        title: json['title'],
        description: json['description'],
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'ProprietaryJSON',
        'title': title,
        if (description != null) 'description': description,
        'value': value,
      };

  @override
  String toString() => 'ProprietaryJSON(title: $title, description: $description, value: $value)';

  @override
  List<Object?> get props => [title, description, value];
}
