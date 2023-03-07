import 'identity_attriube_value.dart';

class CommunicationLanguage extends IdentityAttributeValue {
  final String value;

  CommunicationLanguage({
    required this.value,
  });

  factory CommunicationLanguage.fromJson(Map<String, dynamic> json) => CommunicationLanguage(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'CommunicationLanguage',
        'value': value,
      };

  @override
  String toString() => 'CommunicationLanguage(value: $value)';
}
