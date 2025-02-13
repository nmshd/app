import 'identity_attribute_value.dart';

class BirthCityAttributeValue extends IdentityAttributeValue {
  final String value;

  const BirthCityAttributeValue({required this.value}) : super('BirthCity');

  factory BirthCityAttributeValue.fromJson(Map json) => BirthCityAttributeValue(value: json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'value': value};

  @override
  List<Object?> get props => [value];
}
