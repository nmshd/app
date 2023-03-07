import 'identity_attriube_value.dart';

class EMailAddress extends IdentityAttributeValue {
  final String value;
  EMailAddress({
    required this.value,
  });

  factory EMailAddress.fromJson(Map<String, dynamic> json) => EMailAddress(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'EMailAddress',
        'value': value,
      };

  @override
  String toString() => 'EMailAddress(value: $value)';
}
