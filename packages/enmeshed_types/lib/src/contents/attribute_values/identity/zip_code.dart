import 'identity_attribute_value.dart';

class ZipCode extends IdentityAttributeValue {
  final String value;

  const ZipCode({
    required this.value,
  });

  factory ZipCode.fromJson(Map<String, dynamic> json) => ZipCode(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'ZipCode',
        'value': value,
      };

  @override
  String toString() => 'ZipCode(value: $value)';

  @override
  List<Object?> get props => [value];
}
