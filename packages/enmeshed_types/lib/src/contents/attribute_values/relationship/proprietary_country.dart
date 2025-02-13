import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryCountryAttributeValue extends ProprietaryAttributeValue {
  final String value;

  const ProprietaryCountryAttributeValue({required super.title, super.description, super.valueHintsOverride, required this.value})
    : super('ProprietaryCountry');

  factory ProprietaryCountryAttributeValue.fromJson(Map json) => ProprietaryCountryAttributeValue(
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
