import 'identity_attriube_value.dart';

class GivenName extends IdentityAttributeValue {
  final String value;
  GivenName({
    required this.value,
  });

  factory GivenName.fromJson(Map<String, dynamic> json) => GivenName(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'GivenName',
        'value': value,
      };

  @override
  String toString() => 'GivenName(value: $value)';
}
