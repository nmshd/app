import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryURLAttributeValue extends ProprietaryAttributeValueAttributeValue {
  final String value;

  const ProprietaryURLAttributeValue({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryURLAttributeValue.fromJson(Map json) => ProprietaryURLAttributeValue(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryURL',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryURLAttributeValue(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}
