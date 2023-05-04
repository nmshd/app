import 'identity_attribute_value.dart';

class CountryAttributeValue extends IdentityAttributeValue {
  final String value;

  const CountryAttributeValue({
    required this.value,
  });

  factory CountryAttributeValue.fromJson(Map json) => CountryAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Country',
        'value': value,
      };

  @override
  String toString() => 'CountryAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
