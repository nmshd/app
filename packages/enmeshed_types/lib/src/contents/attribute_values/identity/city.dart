import 'identity_attriube_value.dart';

class City extends IdentityAttributeValue {
  final String value;

  City({
    required this.value,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'City',
        'value': value,
      };

  @override
  String toString() => 'City(value: $value)';
}
