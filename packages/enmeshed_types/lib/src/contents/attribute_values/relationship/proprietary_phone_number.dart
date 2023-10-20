import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryPhoneNumberAttributeValue extends ProprietaryAttributeValue {
  final String value;

  const ProprietaryPhoneNumberAttributeValue({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  }) : super('ProprietaryPhoneNumber');

  factory ProprietaryPhoneNumberAttributeValue.fromJson(Map json) => ProprietaryPhoneNumberAttributeValue(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'value': value,
      };

  @override
  String toString() => 'ProprietaryPhoneNumberAttributeValue(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}
