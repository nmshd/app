import 'identity_attribute_value.dart';

class PhoneNumberAttributeValue extends IdentityAttributeValue {
  final String value;

  const PhoneNumberAttributeValue({
    required this.value,
  });

  factory PhoneNumberAttributeValue.fromJson(Map json) => PhoneNumberAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'PhoneNumber',
        'value': value,
      };

  @override
  String toString() => 'PhoneNumberAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
