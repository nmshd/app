import 'identity_attribute_value.dart';

class DeliveryBoxAddressAttributeValue extends IdentityAttributeValue {
  final String recipient;
  final String deliveryBoxId;
  final String userId;
  final String zipCode;
  final String city;
  final String country;
  final String? phoneNumber;
  final String? state;

  const DeliveryBoxAddressAttributeValue({
    required this.recipient,
    required this.deliveryBoxId,
    required this.userId,
    required this.zipCode,
    required this.city,
    required this.country,
    this.phoneNumber,
    this.state,
  }) : super('DeliveryBoxAddress');

  factory DeliveryBoxAddressAttributeValue.fromJson(Map json) => DeliveryBoxAddressAttributeValue(
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
        '@type': super.atType,
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
    return 'DeliveryBoxAddressAttributeValue(recipient: $recipient, deliveryBoxId: $deliveryBoxId, userId: $userId, zipCode: $zipCode, city: $city, country: $country, phoneNumber: $phoneNumber, state: $state)';
  }

  @override
  List<Object?> get props => [recipient, deliveryBoxId, userId, zipCode, city, country, phoneNumber, state];
}
