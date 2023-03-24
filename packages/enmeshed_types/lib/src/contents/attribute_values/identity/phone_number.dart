import 'identity_attribute_value.dart';

class PhoneNumber extends IdentityAttributeValue {
  final String value;

  const PhoneNumber({
    required this.value,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'PhoneNumber',
        'value': value,
      };

  @override
  String toString() => 'PhoneNumber(value: $value)';

  @override
  List<Object?> get props => [value];
}
