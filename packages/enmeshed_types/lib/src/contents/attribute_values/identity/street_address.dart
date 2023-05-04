import 'identity_attribute_value.dart';

class StreetAddressAttributeValue extends IdentityAttributeValue {
  final String recipient;
  final String street;
  final String houseNumber;
  final String zipCode;
  final String city;
  final String country;
  final String state;

  const StreetAddressAttributeValue({
    required this.recipient,
    required this.street,
    required this.houseNumber,
    required this.zipCode,
    required this.city,
    required this.country,
    required this.state,
  });

  factory StreetAddressAttributeValue.fromJson(Map json) => StreetAddressAttributeValue(
        recipient: json['recipient'],
        street: json['street'],
        houseNumber: json['houseNumber'],
        zipCode: json['zipCode'],
        city: json['city'],
        country: json['country'],
        state: json['state'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'StreetAddress',
        'recipient': recipient,
        'street': street,
        'houseNumber': houseNumber,
        'zipCode': zipCode,
        'city': city,
        'country': country,
        'state': state,
      };

  @override
  String toString() {
    return 'StreetAddressAttributeValue(recipient: $recipient, street: $street, houseNumber: $houseNumber, zipCode: $zipCode, city: $city, country: $country, state: $state)';
  }

  @override
  List<Object?> get props => [recipient, street, zipCode, city, country, state];
}
