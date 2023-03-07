import 'identity_attriube_value.dart';

class BirthDay extends IdentityAttributeValue {
  final int value;
  BirthDay({
    required this.value,
  });

  factory BirthDay.fromJson(Map<String, dynamic> json) => BirthDay(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthDay',
        'value': value,
      };

  @override
  String toString() => 'BirthDay(value: $value)';
}
