import 'identity_attribute_value.dart';

class BirthNameAttributeValue extends IdentityAttributeValue {
  final String value;

  const BirthNameAttributeValue({
    required this.value,
  });

  factory BirthNameAttributeValue.fromJson(Map json) => BirthNameAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthName',
        'value': value,
      };

  @override
  String toString() => 'BirthNameAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
