import 'identity_attribute_value.dart';

class BirthNameAttributeValue extends IdentityAttributeValue {
  final String value;

  const BirthNameAttributeValue({
    required this.value,
  }) : super('BirthName');

  factory BirthNameAttributeValue.fromJson(Map json) => BirthNameAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  String toString() => 'BirthNameAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
