import 'identity_attribute_value.dart';

class PostOfficeBoxAddressAttributeValue extends IdentityAttributeValue {
  final String recipient;
  final String boxId;
  final String zipCode;
  final String city;
  final String country;
  final String? state;

  const PostOfficeBoxAddressAttributeValue({
    required this.recipient,
    required this.boxId,
    required this.zipCode,
    required this.city,
    required this.country,
    this.state,
  }) : super('PostOfficeBoxAddress');

  factory PostOfficeBoxAddressAttributeValue.fromJson(Map json) => PostOfficeBoxAddressAttributeValue(
    recipient: json['recipient'],
    boxId: json['boxId'],
    zipCode: json['zipCode'],
    city: json['city'],
    country: json['country'],
    state: json['state'],
  );

  @override
  Map<String, dynamic> toJson() => {
    '@type': super.atType,
    'recipient': recipient,
    'boxId': boxId,
    'zipCode': zipCode,
    'city': city,
    'country': country,
    if (state != null) 'state': state,
  };

  @override
  List<Object?> get props => [recipient, boxId, zipCode, city, country, state];
}
