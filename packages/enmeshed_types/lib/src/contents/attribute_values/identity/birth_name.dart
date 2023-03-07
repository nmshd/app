import 'identity_attriube_value.dart';

class BirthName extends IdentityAttributeValue {
  final String value;
  BirthName({
    required this.value,
  });

  factory BirthName.fromJson(Map<String, dynamic> json) => BirthName(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthName',
        'value': value,
      };

  @override
  String toString() => 'BirthName(value: $value)';
}
