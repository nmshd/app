import 'identity_attribute_value.dart';

class PhoneNumberAttributeValue extends IdentityAttributeValue {
  final String value;

  const PhoneNumberAttributeValue({
    required this.value,
  }) : super('PhoneNumber');

  factory PhoneNumberAttributeValue.fromJson(Map json) => PhoneNumberAttributeValue(
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
