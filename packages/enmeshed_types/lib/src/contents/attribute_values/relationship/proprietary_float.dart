import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryFloat extends ProprietaryAttributeValue {
  final double value;
  ProprietaryFloat({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryFloat.fromJson(Map<String, dynamic> json) => ProprietaryFloat(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryFloat',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryFloat(value: $value)';
}
