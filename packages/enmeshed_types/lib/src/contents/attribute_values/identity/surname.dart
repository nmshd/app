import 'identity_attriube_value.dart';

class Surname extends IdentityAttributeValue {
  final String value;

  Surname({
    required this.value,
  });

  factory Surname.fromJson(Map<String, dynamic> json) => Surname(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Surname',
        'value': value,
      };

  @override
  String toString() => 'Surname(value: $value)';
}
