import 'identity_attriube_value.dart';

class DeliveryBoxAddress extends IdentityAttributeValue {
  final String recipient;
  final String deliveryBoxId;
  final String userId;
  final String zipCode;
  final String city;
  final String country;
  final String? phoneNumber;
  final String? state;
  DeliveryBoxAddress({
    required this.recipient,
    required this.deliveryBoxId,
    required this.userId,
    required this.zipCode,
    required this.city,
    required this.country,
    this.phoneNumber,
    this.state,
  });

  factory DeliveryBoxAddress.fromJson(Map<String, dynamic> json) => DeliveryBoxAddress(
        recipient: json['recipient'],
        deliveryBoxId: json['deliveryBoxId'],
        userId: json['userId'],
        zipCode: json['zipCode'],
        city: json['city'],
        country: json['country'],
        phoneNumber: json['phoneNumber'],
        state: json['state'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'DeliveryBoxAddress',
        'recipient': recipient,
        'deliveryBoxId': deliveryBoxId,
        'userId': userId,
        'zipCode': zipCode,
        'city': city,
        'country': country,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (state != null) 'state': state,
      };

  @override
  String toString() {
    return 'DeliveryBoxAddress(recipient: $recipient, deliveryBoxId: $deliveryBoxId, userId: $userId, zipCode: $zipCode, city: $city, country: $country, phoneNumber: $phoneNumber, state: $state)';
  }
}
