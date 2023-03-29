import 'identity_attribute_value.dart';

class MiddleName extends IdentityAttributeValue {
  final String value;

  const MiddleName({
    required this.value,
  });

  factory MiddleName.fromJson(Map<String, dynamic> json) => MiddleName(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'MiddleName',
        'value': value,
      };

  @override
  String toString() => 'MiddleName(value: $value)';

  @override
  List<Object?> get props => [value];
}
