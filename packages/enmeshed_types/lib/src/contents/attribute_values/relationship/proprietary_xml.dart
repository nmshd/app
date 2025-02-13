import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryXMLAttributeValue extends ProprietaryAttributeValue {
  final String value;
  final String? schemaURL;

  const ProprietaryXMLAttributeValue({required super.title, super.description, super.valueHintsOverride, required this.value, this.schemaURL})
    : super('ProprietaryXML');

  factory ProprietaryXMLAttributeValue.fromJson(Map json) => ProprietaryXMLAttributeValue(
    title: json['title'],
    description: json['description'],
    valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
    value: json['value'],
    schemaURL: json['schemaURL'],
  );

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'value': value, 'schemaURL': schemaURL};

  @override
  List<Object?> get props => [super.props, value, schemaURL];
}
