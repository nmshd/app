import 'identity_attribute_value.dart';

class ZipCodeAttributeValue extends IdentityAttributeValue {
  final String value;

  const ZipCodeAttributeValue({
    required this.value,
  }) : super('ZipCode');

  factory ZipCodeAttributeValue.fromJson(Map json) => ZipCodeAttributeValue(
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
