import 'identity_attribute_value.dart';

class HouseNumberAttributeValue extends IdentityAttributeValue {
  final String value;

  const HouseNumberAttributeValue({
    required this.value,
  });

  factory HouseNumberAttributeValue.fromJson(Map json) => HouseNumberAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'HouseNumber',
        'value': value,
      };

  @override
  String toString() => 'HouseNumberAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
