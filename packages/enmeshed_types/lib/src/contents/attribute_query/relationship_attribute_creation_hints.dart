part of 'attribute_query.dart';

@JsonSerializable(includeIfNull: false)
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

  factory RelationshipAttributeCreationHints.fromJson(Map json) => _$RelationshipAttributeCreationHintsFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => {'@type': 'RelationshipAttributeCreationHints', ..._$RelationshipAttributeCreationHintsToJson(this)};

  @override
  List<Object?> get props => [title, valueType, description, valueHints, confidentiality];
}
