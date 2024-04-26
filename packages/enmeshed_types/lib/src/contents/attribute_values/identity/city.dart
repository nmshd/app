import 'identity_attribute_value.dart';

class CityAttributeValue extends IdentityAttributeValue {
  final String value;

  const CityAttributeValue({
    required this.value,
  }) : super('City');

  factory CityAttributeValue.fromJson(Map json) => CityAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  List<Object?> get props => [value];
}
