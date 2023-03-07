import 'identity_attriube_value.dart';

class HonorificPrefix extends IdentityAttributeValue {
  final String value;

  HonorificPrefix({
    required this.value,
  });

  factory HonorificPrefix.fromJson(Map<String, dynamic> json) => HonorificPrefix(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'HonorificPrefix',
        'value': value,
      };

  @override
  String toString() => 'HonorificPrefix(value: $value)';
}
