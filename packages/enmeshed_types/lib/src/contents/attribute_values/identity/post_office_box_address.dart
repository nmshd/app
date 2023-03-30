import 'identity_attribute_value.dart';

class PostOfficeBoxAddress extends IdentityAttributeValue {
  final String recipient;
  final String boxId;
  final String zipCode;
  final String city;
  final String country;
  final String? state;

  const PostOfficeBoxAddress({
    required this.recipient,
    required this.boxId,
    required this.zipCode,
    required this.city,
    required this.country,
    this.state,
  });

  factory PostOfficeBoxAddress.fromJson(Map<String, dynamic> json) => PostOfficeBoxAddress(
        recipient: json['recipient'],
        boxId: json['boxId'],
        zipCode: json['zipCode'],
        city: json['city'],
        country: json['country'],
        state: json['state'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'PostOfficeBoxAddress',
        'recipient': recipient,
        'boxId': boxId,
        'zipCode': zipCode,
        'city': city,
        'country': country,
        if (state != null) 'state': state,
      };

  @override
  String toString() {
    return 'PostOfficeBoxAddress(recipient: $recipient, boxId: $boxId, zipCode: $zipCode, city: $city, country: $country, state: $state)';
  }

  @override
  List<Object?> get props => [recipient, boxId, zipCode, city, country, state];
}
