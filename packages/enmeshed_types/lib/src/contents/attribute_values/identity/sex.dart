import 'identity_attribute_value.dart';

class SexAttributeValue extends IdentityAttributeValue {
  final String value;

  const SexAttributeValue({required this.value}) : super('Sex');

  factory SexAttributeValue.fromJson(Map json) => SexAttributeValue(value: json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'value': value};

  @override
  List<Object?> get props => [value];
}
