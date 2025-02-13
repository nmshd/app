import 'identity_attribute_value.dart';

class BirthStateAttributeValue extends IdentityAttributeValue {
  final String value;

  const BirthStateAttributeValue({required this.value}) : super('BirthState');

  factory BirthStateAttributeValue.fromJson(Map json) => BirthStateAttributeValue(value: json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'value': value};

  @override
  List<Object?> get props => [value];
}
