import 'identity_attribute_value.dart';

class CountryAttributeValue extends IdentityAttributeValue {
  final String value;

  const CountryAttributeValue({
    required this.value,
  }) : super('Country');

  factory CountryAttributeValue.fromJson(Map json) => CountryAttributeValue(
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
