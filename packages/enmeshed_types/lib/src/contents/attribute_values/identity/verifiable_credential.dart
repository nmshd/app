import 'identity_attribute_value.dart';

class VerifiableCredentialAttributeValue extends IdentityAttributeValue {
  final String? state;
  final String title;
  final String description;
  final String value;

  const VerifiableCredentialAttributeValue({required this.title, required this.description, required this.value, this.state})
    : super('VerifiableCredential');

  factory VerifiableCredentialAttributeValue.fromJson(Map json) =>
      VerifiableCredentialAttributeValue(title: json['title'], description: json['description'], value: json['value'], state: json['state']);

  @override
  Map<String, dynamic> toJson() => {
    '@type': super.atType,
    'title': title,
    'description': description,
    'value': value,
    if (state != null) 'state': state,
  };

  @override
  List<Object?> get props => [title, description, value, state];
}
