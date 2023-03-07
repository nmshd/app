import 'identity_attriube_value.dart';

class BirthYear extends IdentityAttributeValue {
  final int value;

  BirthYear({
    required this.value,
  });

  factory BirthYear.fromJson(Map<String, dynamic> json) => BirthYear(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthYear',
        'value': value,
      };

  @override
  String toString() => 'BirthYear(value: $value)';
}
