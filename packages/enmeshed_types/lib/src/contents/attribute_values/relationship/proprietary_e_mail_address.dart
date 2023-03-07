import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryEMailAddress extends ProprietaryAttributeValue {
  final String value;

  ProprietaryEMailAddress({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  });

  factory ProprietaryEMailAddress.fromJson(Map<String, dynamic> json) => ProprietaryEMailAddress(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ProprietaryEMailAddress',
        'value': value,
      };

  @override
  String toString() => 'ProprietaryEMailAddress(value: $value)';
}
