import 'identity_attribute_value.dart';

class NationalityAttributeValue extends IdentityAttributeValue {
  final String value;

  const NationalityAttributeValue({
    required this.value,
  });

  factory NationalityAttributeValue.fromJson(Map json) => NationalityAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Nationality',
        'value': value,
      };

  @override
  String toString() => 'NationalityAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
