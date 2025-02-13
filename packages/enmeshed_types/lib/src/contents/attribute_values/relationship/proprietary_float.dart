import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryFloatAttributeValue extends ProprietaryAttributeValue {
  final double value;

  const ProprietaryFloatAttributeValue({required super.title, super.description, super.valueHintsOverride, required this.value})
    : super('ProprietaryFloat');

  factory ProprietaryFloatAttributeValue.fromJson(Map json) => ProprietaryFloatAttributeValue(
    title: json['title'],
    description: json['description'],
    valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
    value: json['value'],
  );

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'value': value};

  @override
  List<Object?> get props => [super.props, value];
}
