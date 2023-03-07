import 'identity_attriube_value.dart';

class BirthState extends IdentityAttributeValue {
  final String value;
  BirthState({
    required this.value,
  });

  factory BirthState.fromJson(Map<String, dynamic> json) => BirthState(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthState',
        'value': value,
      };

  @override
  String toString() => 'BirthState(value: $value)';
}
