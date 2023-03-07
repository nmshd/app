import 'identity_attriube_value.dart';

class Country extends IdentityAttributeValue {
  final String value;
  Country({
    required this.value,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Country',
        'value': value,
      };

  @override
  String toString() => 'Country(value: $value)';
}
