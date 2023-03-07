import 'identity_attriube_value.dart';

class Street extends IdentityAttributeValue {
  final String value;
  Street({
    required this.value,
  });

  factory Street.fromJson(Map<String, dynamic> json) => Street(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Street',
        'value': value,
      };

  @override
  String toString() => 'Street(value: $value)';
}
