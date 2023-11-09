import 'identity_attribute_value.dart';

class StreetAttributeValue extends IdentityAttributeValue {
  final String value;

  const StreetAttributeValue({
    required this.value,
  }) : super('Street');

  factory StreetAttributeValue.fromJson(Map json) => StreetAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  String toString() => 'StreetAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
