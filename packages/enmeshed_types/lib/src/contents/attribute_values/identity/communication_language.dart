import 'identity_attribute_value.dart';

class CommunicationLanguageAttributeValue extends IdentityAttributeValue {
  final String value;

  const CommunicationLanguageAttributeValue({
    required this.value,
  });

  factory CommunicationLanguageAttributeValue.fromJson(Map json) => CommunicationLanguageAttributeValue(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'CommunicationLanguage',
        'value': value,
      };

  @override
  String toString() => 'CommunicationLanguageAttributeValue(value: $value)';

  @override
  List<Object?> get props => [value];
}
