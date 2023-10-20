import 'identity_attribute_value.dart';

class BirthYearAttributeValue extends IdentityAttributeValue {
  final int value;

  const BirthYearAttributeValue({
    required this.value,
  }) : super('BirthYear');

  factory BirthYearAttributeValue.fromJson(Map json) => BirthYearAttributeValue(
        value: json['value'].toInt(),
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  String toString() => 'BirthYearAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
