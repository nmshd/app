import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryLanguage extends ProprietaryAttributeValue {
  final String value;
  ProprietaryLanguage({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryLanguage.fromJson(Map<String, dynamic> json) => ProprietaryLanguage(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryLanguage',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryLanguage(value: $value)';
}
