import 'identity_attribute_value.dart';

class HonorificPrefixAttributeValue extends IdentityAttributeValue {
  final String value;

  const HonorificPrefixAttributeValue({
    required this.value,
  });

  factory HonorificPrefixAttributeValue.fromJson(Map json) => HonorificPrefixAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'HonorificPrefix',
        'value': value,
      };

  @override
  String toString() => 'HonorificPrefixAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
