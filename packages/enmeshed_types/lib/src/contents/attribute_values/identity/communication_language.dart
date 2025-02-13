import 'identity_attribute_value.dart';

class CommunicationLanguageAttributeValue extends IdentityAttributeValue {
  final String value;

  const CommunicationLanguageAttributeValue({required this.value}) : super('CommunicationLanguage');

  factory CommunicationLanguageAttributeValue.fromJson(Map json) => CommunicationLanguageAttributeValue(value: json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': super.atType, 'value': value};

  @override
  List<Object?> get props => [value];
}
