import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryFileReference extends ProprietaryAttributeValue {
  final String value;

  const ProprietaryFileReference({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryFileReference.fromJson(Map json) => ProprietaryFileReference(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryFileReference',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryFileReference(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}
