import 'identity_attribute_value.dart';

class CitizenshipAttributeValue extends IdentityAttributeValue {
  final String value;

  const CitizenshipAttributeValue({
    required this.value,
  }) : super('Citizenship');

  factory CitizenshipAttributeValue.fromJson(Map json) => CitizenshipAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  String toString() => 'CitizenshipAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
