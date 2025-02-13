import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryHEXColorAttributeValue extends ProprietaryAttributeValue {
  final String value;

  const ProprietaryHEXColorAttributeValue({required super.title, super.description, super.valueHintsOverride, required this.value})
    : super('ProprietaryHEXColor');

  factory ProprietaryHEXColorAttributeValue.fromJson(Map json) => ProprietaryHEXColorAttributeValue(
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
