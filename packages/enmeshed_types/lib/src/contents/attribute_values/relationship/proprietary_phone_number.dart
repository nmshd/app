import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryPhoneNumber extends ProprietaryAttributeValue {
  final String value;

  ProprietaryPhoneNumber({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryPhoneNumber.fromJson(Map<String, dynamic> json) => ProprietaryPhoneNumber(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryPhoneNumber',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryPhoneNumber(value: $value)';
}
