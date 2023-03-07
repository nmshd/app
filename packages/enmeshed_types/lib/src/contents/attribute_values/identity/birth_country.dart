import 'identity_attriube_value.dart';

class BirthCountry extends IdentityAttributeValue {
  final String value;
  BirthCountry({
    required this.value,
  });

  factory BirthCountry.fromJson(Map<String, dynamic> json) => BirthCountry(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthCountry',
        'value': value,
      };

  @override
  String toString() => 'BirthCountry(value: $value)';
}
