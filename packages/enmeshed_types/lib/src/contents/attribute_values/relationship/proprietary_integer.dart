import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryIntegerAttributeValue extends ProprietaryAttributeValue {
  final int value;

  const ProprietaryIntegerAttributeValue({required super.title, super.description, super.valueHintsOverride, required this.value})
    : super('ProprietaryInteger');

  factory ProprietaryIntegerAttributeValue.fromJson(Map json) => ProprietaryIntegerAttributeValue(
    title: json['title'],
    description: json['description'],
    valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
    value: json['value'].toInt(),
  );

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'value': value};

  @override
  List<Object?> get props => [...super.props, value];
}
