import 'identity_attriube_value.dart';

class BirthCity extends IdentityAttributeValue {
  final String value;
  BirthCity({
    required this.value,
  });

  factory BirthCity.fromJson(Map<String, dynamic> json) => BirthCity(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthCity',
        'value': value,
      };

  @override
  String toString() => 'BirthCity(value: $value)';
}
