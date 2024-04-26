import 'identity_attribute_value.dart';

class BirthDayAttributeValue extends IdentityAttributeValue {
  final int value;

  const BirthDayAttributeValue({
    required this.value,
  }) : super('BirthDay');

  factory BirthDayAttributeValue.fromJson(Map json) => BirthDayAttributeValue(
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
