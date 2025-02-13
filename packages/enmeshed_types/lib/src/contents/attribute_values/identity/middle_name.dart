import 'identity_attribute_value.dart';

class MiddleNameAttributeValue extends IdentityAttributeValue {
  final String value;

  const MiddleNameAttributeValue({required this.value}) : super('MiddleName');

  factory MiddleNameAttributeValue.fromJson(Map json) => MiddleNameAttributeValue(value: json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'value': value};

  @override
  List<Object?> get props => [value];
}
