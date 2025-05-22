import 'identity_attribute_value.dart';

class HonorificSuffixAttributeValue extends IdentityAttributeValue {
  final String value;

  const HonorificSuffixAttributeValue({required this.value}) : super('HonorificSuffix');

  factory HonorificSuffixAttributeValue.fromJson(Map json) => HonorificSuffixAttributeValue(value: json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'value': value};

  @override
  List<Object?> get props => [value];
}
