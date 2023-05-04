import 'identity_attribute_value.dart';

class DisplayNameAttributeValue extends IdentityAttributeValue {
  final String value;

  const DisplayNameAttributeValue({
    required this.value,
  });

  factory DisplayNameAttributeValue.fromJson(Map json) => DisplayNameAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'DisplayName',
        'value': value,
      };

  @override
  String toString() => 'DisplayNameAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
