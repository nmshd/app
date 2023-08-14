import 'identity_attribute_value.dart';

class SchematizedXMLAttributeValue extends IdentityAttributeValue {
  final String value;
  final String? schemaURL;

  const SchematizedXMLAttributeValue({
    required this.value,
    this.schemaURL,
  });

  factory SchematizedXMLAttributeValue.fromJson(Map json) => SchematizedXMLAttributeValue(
        value: json['value'],
        schemaURL: json['schemaURL'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'SchematizedXML',
        'value': value,
        'schemaURL': schemaURL,
      };

  @override
  List<Object?> get props => [value, schemaURL];
}
