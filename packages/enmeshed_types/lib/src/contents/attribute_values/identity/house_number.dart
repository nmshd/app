import 'identity_attribute_value.dart';

class HouseNumber extends IdentityAttributeValue {
  final String value;

  const HouseNumber({
    required this.value,
  });

  factory HouseNumber.fromJson(Map json) => HouseNumber(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'HouseNumber',
        'value': value,
      };

  @override
  String toString() => 'HouseNumber(value: $value)';

  @override
  List<Object?> get props => [value];
}
