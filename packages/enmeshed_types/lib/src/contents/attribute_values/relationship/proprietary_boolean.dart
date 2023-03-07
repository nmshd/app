import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryBoolean extends ProprietaryAttributeValue {
  final bool value;
  ProprietaryBoolean({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryBoolean.fromJson(Map<String, dynamic> json) => ProprietaryBoolean(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryBoolean',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryBoolean(value: $value)';
}
