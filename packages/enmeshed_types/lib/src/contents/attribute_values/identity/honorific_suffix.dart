import 'identity_attriube_value.dart';

class HonorificSuffix extends IdentityAttributeValue {
  final String value;
  HonorificSuffix({
    required this.value,
  });

  factory HonorificSuffix.fromJson(Map<String, dynamic> json) => HonorificSuffix(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'HonorificSuffix',
        'value': value,
      };

  @override
  String toString() => 'HonorificSuffix(value: $value)';
}
