import '../../value_hints.dart';
import 'relationship_attribute_value.dart';

abstract class ProprietaryAttributeValue extends RelationshipAttributeValue {
  final String title;
  final String? description;
  final ValueHints? valueHintsOverride;

  const ProprietaryAttributeValue(super.atType, {required this.title, this.description, this.valueHintsOverride});

  @override
  Map<String, dynamic> toJson() => {
    '@type': super.atType,
    'title': title,
    if (description != null) 'description': description,
    if (valueHintsOverride != null) 'valueHintsOverride': valueHintsOverride?.toJson(),
  };

  @override
  List<Object?> get props => [title, description, valueHintsOverride];
}
