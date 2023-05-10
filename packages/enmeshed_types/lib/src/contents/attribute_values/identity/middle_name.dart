import 'identity_attribute_value.dart';

class MiddleNameAttributeValue extends IdentityAttributeValue {
  final String value;

  const MiddleNameAttributeValue({
    required this.value,
  });

  factory MiddleNameAttributeValue.fromJson(Map json) => MiddleNameAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'MiddleName',
        'value': value,
      };

  @override
  String toString() => 'MiddleNameAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
