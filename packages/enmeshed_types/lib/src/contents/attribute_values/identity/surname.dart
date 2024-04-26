import 'identity_attribute_value.dart';

class SurnameAttributeValue extends IdentityAttributeValue {
  final String value;

  const SurnameAttributeValue({
    required this.value,
  }) : super('Surname');

  factory SurnameAttributeValue.fromJson(Map json) => SurnameAttributeValue(
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
