import 'identity_attriube_value.dart';

class BirthMonth extends IdentityAttributeValue {
  final int value;
  BirthMonth({
    required this.value,
  });

  factory BirthMonth.fromJson(Map<String, dynamic> json) => BirthMonth(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthMonth',
        'value': value,
      };

  @override
  String toString() => 'BirthMonth(value: $value)';
}
