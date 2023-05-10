import 'identity_attribute_value.dart';

class SexAttributeValue extends IdentityAttributeValue {
  final String value;

  const SexAttributeValue({
    required this.value,
  });

  factory SexAttributeValue.fromJson(Map json) => SexAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Sex',
        'value': value,
      };

  @override
  String toString() => 'SexAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
