import 'identity_attribute_value.dart';

class BirthMonthAttributeValue extends IdentityAttributeValue {
  final int value;

  const BirthMonthAttributeValue({
    required this.value,
  }) : super('BirthMonth');

  factory BirthMonthAttributeValue.fromJson(Map json) => BirthMonthAttributeValue(
        value: json['value'].toInt(),
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'value': value,
      };

  @override
  List<Object?> get props => [value];
}
