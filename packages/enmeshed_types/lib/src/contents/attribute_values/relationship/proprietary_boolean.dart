import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryBooleanAttributeValue extends ProprietaryAttributeValue {
  final bool value;

  const ProprietaryBooleanAttributeValue({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  }) : super('ProprietaryBoolean');

  factory ProprietaryBooleanAttributeValue.fromJson(Map json) => ProprietaryBooleanAttributeValue(
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
  String toString() => 'ProprietaryBooleanAttributeValue(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}
