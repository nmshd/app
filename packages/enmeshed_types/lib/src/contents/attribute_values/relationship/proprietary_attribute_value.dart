import '../../value_hints.dart';
import 'relationship_attribute_value.dart';

abstract class ProprietaryAttributeValue extends RelationshipAttributeValue {
  final String title;
  final String? description;
  final ValueHints? valueHintsOverride;

  const ProprietaryAttributeValue({
    required this.title,
    this.description,
    this.valueHintsOverride,
  });

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        if (description != null) 'description': description,
        if (valueHintsOverride != null) 'valueHintsOverride': valueHintsOverride?.toJson(),
      };

  @override
  String toString() => 'ProprietaryAttributeValueAttributeValue(title: $title, description: $description, valueHintsOverride: $valueHintsOverride)';

  @override
  List<Object?> get props => [title, description, valueHintsOverride];
}
