import 'identity_attribute_value.dart';

class BirthCountryAttributeValue extends IdentityAttributeValue {
  final String value;

  const BirthCountryAttributeValue({
    required this.value,
  });

  factory BirthCountryAttributeValue.fromJson(Map json) => BirthCountryAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthCountry',
        'value': value,
      };

  @override
  String toString() => 'BirthCountryAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
