import 'identity_attriube_value.dart';

class FaxNumber extends IdentityAttributeValue {
  final String value;

  FaxNumber({
    required this.value,
  });

  factory FaxNumber.fromJson(Map<String, dynamic> json) => FaxNumber(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'FaxNumber',
        'value': value,
      };

  @override
  String toString() => 'FaxNumber(value: $value)';
}
