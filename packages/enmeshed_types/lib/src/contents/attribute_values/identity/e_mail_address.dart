import 'identity_attribute_value.dart';

class EMailAddressAttributeValue extends IdentityAttributeValue {
  final String value;

  const EMailAddressAttributeValue({
    required this.value,
  });

  factory EMailAddressAttributeValue.fromJson(Map json) => EMailAddressAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'EMailAddress',
        'value': value,
      };

  @override
  String toString() => 'EMailAddressAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
