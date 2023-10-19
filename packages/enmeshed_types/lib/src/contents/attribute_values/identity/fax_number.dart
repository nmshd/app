import 'identity_attribute_value.dart';

class FaxNumberAttributeValue extends IdentityAttributeValue {
  final String value;

  const FaxNumberAttributeValue({
    required this.value,
  }) : super('FaxNumber');

  factory FaxNumberAttributeValue.fromJson(Map json) => FaxNumberAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  String toString() => 'FaxNumberAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
