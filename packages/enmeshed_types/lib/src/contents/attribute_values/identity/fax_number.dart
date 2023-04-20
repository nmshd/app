import 'identity_attribute_value.dart';

class FaxNumber extends IdentityAttributeValue {
  final String value;

  const FaxNumber({
    required this.value,
  });

  factory FaxNumber.fromJson(Map json) => FaxNumber(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'FaxNumber',
        'value': value,
      };

  @override
  String toString() => 'FaxNumber(value: $value)';

  @override
  List<Object?> get props => [value];
}
