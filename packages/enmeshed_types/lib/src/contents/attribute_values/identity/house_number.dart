import 'identity_attriube_value.dart';

class HouseNumber extends IdentityAttributeValue {
  final String value;

  HouseNumber({
    required this.value,
  });

  factory HouseNumber.fromJson(Map<String, dynamic> json) => HouseNumber(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'HouseNumber',
        'value': value,
      };

  @override
  String toString() => 'HouseNumber(value: $value)';
}
