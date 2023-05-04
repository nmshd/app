import 'identity_attribute_value.dart';

class BirthStateAttributeValue extends IdentityAttributeValue {
  final String value;

  const BirthStateAttributeValue({
    required this.value,
  });

  factory BirthStateAttributeValue.fromJson(Map json) => BirthStateAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthState',
        'value': value,
      };

  @override
  String toString() => 'BirthStateAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
