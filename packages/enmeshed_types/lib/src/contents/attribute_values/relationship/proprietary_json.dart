import 'relationship_attribute_value.dart';

class ProprietaryJSONAttributeValue extends RelationshipAttributeValue {
  final String title;
  final String? description;
  // can be anything json can be (Map<String, dynamic>, List<dynamic>, String, int, double, bool, null)
  final dynamic value;

  const ProprietaryJSONAttributeValue({
    required this.title,
    this.description,
    required this.value,
  }) : super('ProprietaryJSON');

  factory ProprietaryJSONAttributeValue.fromJson(Map json) => ProprietaryJSONAttributeValue(
        title: json['title'],
        description: json['description'],
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'title': title,
        if (description != null) 'description': description,
        'value': value,
      };

  @override
  String toString() => 'ProprietaryJSONAttributeValue(title: $title, description: $description, value: $value)';

  @override
  List<Object?> get props => [title, description, value];
}
