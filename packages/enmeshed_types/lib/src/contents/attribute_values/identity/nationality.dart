import 'identity_attriube_value.dart';

class Nationality extends IdentityAttributeValue {
  final String value;

  Nationality({
    required this.value,
  });

  factory Nationality.fromJson(Map<String, dynamic> json) => Nationality(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Nationality',
        'value': value,
      };

  @override
  String toString() => 'Nationality(value: $value)';
}
