import 'identity_attribute_value.dart';

class GivenNameAttributeValue extends IdentityAttributeValue {
  final String value;

  const GivenNameAttributeValue({
    required this.value,
  }) : super('GivenName');

  factory GivenNameAttributeValue.fromJson(Map json) => GivenNameAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  String toString() => 'GivenNameAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
