import 'identity_attribute_value.dart';

class CommunicationLanguage extends IdentityAttributeValue {
  final String value;

  const CommunicationLanguage({
    required this.value,
  });

  factory CommunicationLanguage.fromJson(Map json) => CommunicationLanguage(
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'CommunicationLanguage',
        'value': value,
      };

  @override
  String toString() => 'CommunicationLanguage(value: $value)';

  @override
  List<Object?> get props => [value];
}
