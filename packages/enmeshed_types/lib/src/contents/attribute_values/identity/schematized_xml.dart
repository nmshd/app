import 'identity_attribute_value.dart';

class SchematizedXMLAttributeValue extends IdentityAttributeValue {
  final String value;
  final String? schemaURL;

  const SchematizedXMLAttributeValue({required this.value, this.schemaURL}) : super('SchematizedXML');

  factory SchematizedXMLAttributeValue.fromJson(Map json) => SchematizedXMLAttributeValue(value: json['value'], schemaURL: json['schemaURL']);

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'value': value, 'schemaURL': schemaURL};

  @override
  List<Object?> get props => [value, schemaURL];
}
