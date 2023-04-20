import 'identity_attribute_value.dart';

class HonorificPrefix extends IdentityAttributeValue {
  final String value;

  const HonorificPrefix({
    required this.value,
  });

  factory HonorificPrefix.fromJson(Map json) => HonorificPrefix(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'HonorificPrefix',
        'value': value,
      };

  @override
  String toString() => 'HonorificPrefix(value: $value)';

  @override
  List<Object?> get props => [value];
}
