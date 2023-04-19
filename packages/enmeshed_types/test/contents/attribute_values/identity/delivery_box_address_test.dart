import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('DeliveryBoxAddress toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = DeliveryBoxAddress(
        recipient: 'aRecipient',
        deliveryBoxId: 'aDeliveryBoxId',
        userId: 'anUserId',
        zipCode: 'aZipCode',
        city: 'aCity',
        country: 'aCountry',
      );
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'DeliveryBoxAddress',
          'recipient': 'aRecipient',
          'deliveryBoxId': 'aDeliveryBoxId',
          'userId': 'anUserId',
          'zipCode': 'aZipCode',
          'city': 'aCity',
          'country': 'aCountry',
        }),
      );
    });

    test('is correctly converted with property "phoneNumber"', () {
      const identityAttributeValue = DeliveryBoxAddress(
        recipient: 'aRecipient',
        deliveryBoxId: 'aDeliveryBoxId',
        userId: 'anUserId',
        zipCode: 'aZipCode',
        city: 'aCity',
        country: 'aCountry',
        phoneNumber: 'aPhoneNumber',
      );
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'DeliveryBoxAddress',
          'recipient': 'aRecipient',
          'deliveryBoxId': 'aDeliveryBoxId',
          'userId': 'anUserId',
          'zipCode': 'aZipCode',
          'city': 'aCity',
          'country': 'aCountry',
          'phoneNumber': 'aPhoneNumber',
        }),
      );
    });

    test('is correctly converted with property "state"', () {
      const identityAttributeValue = DeliveryBoxAddress(
        recipient: 'aRecipient',
        deliveryBoxId: 'aDeliveryBoxId',
        userId: 'anUserId',
        zipCode: 'aZipCode',
        city: 'aCity',
        country: 'aCountry',
        state: 'aState',
      );
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'DeliveryBoxAddress',
          'recipient': 'aRecipient',
          'deliveryBoxId': 'aDeliveryBoxId',
          'userId': 'anUserId',
          'zipCode': 'aZipCode',
          'city': 'aCity',
          'country': 'aCountry',
          'state': 'aState',
        }),
      );
    });

    test('is correctly converted with properties "phoneNumber" and "state"', () {
      const identityAttributeValue = DeliveryBoxAddress(
        recipient: 'aRecipient',
        deliveryBoxId: 'aDeliveryBoxId',
        userId: 'anUserId',
        zipCode: 'aZipCode',
        city: 'aCity',
        country: 'aCountry',
        phoneNumber: 'aPhoneNumber',
        state: 'aState',
      );
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'DeliveryBoxAddress',
          'recipient': 'aRecipient',
          'deliveryBoxId': 'aDeliveryBoxId',
          'userId': 'anUserId',
          'zipCode': 'aZipCode',
          'city': 'aCity',
          'country': 'aCountry',
          'phoneNumber': 'aPhoneNumber',
          'state': 'aState',
        }),
      );
    });
  });

  group('DeliveryBoxAddress fromJson', () {
    test('is correctly converted', () {
      final json = {
        'recipient': 'aRecipient',
        'deliveryBoxId': 'aDeliveryBoxId',
        'userId': 'anUserId',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'aCountry',
      };
      expect(
        DeliveryBoxAddress.fromJson(json),
        equals(const DeliveryBoxAddress(
          recipient: 'aRecipient',
          deliveryBoxId: 'aDeliveryBoxId',
          userId: 'anUserId',
          zipCode: 'aZipCode',
          city: 'aCity',
          country: 'aCountry',
        )),
      );
    });

    test('is correctly converted with property "phoneNumber"', () {
      final json = {
        'recipient': 'aRecipient',
        'deliveryBoxId': 'aDeliveryBoxId',
        'userId': 'anUserId',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'aCountry',
        'phoneNumber': 'aPhoneNumber',
      };
      expect(
        DeliveryBoxAddress.fromJson(json),
        equals(const DeliveryBoxAddress(
          recipient: 'aRecipient',
          deliveryBoxId: 'aDeliveryBoxId',
          userId: 'anUserId',
          zipCode: 'aZipCode',
          city: 'aCity',
          country: 'aCountry',
          phoneNumber: 'aPhoneNumber',
        )),
      );
    });

    test('is correctly converted with property "state"', () {
      final json = {
        'recipient': 'aRecipient',
        'deliveryBoxId': 'aDeliveryBoxId',
        'userId': 'anUserId',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'aCountry',
        'state': 'aState',
      };
      expect(
        DeliveryBoxAddress.fromJson(json),
        equals(const DeliveryBoxAddress(
          recipient: 'aRecipient',
          deliveryBoxId: 'aDeliveryBoxId',
          userId: 'anUserId',
          zipCode: 'aZipCode',
          city: 'aCity',
          country: 'aCountry',
          state: 'aState',
        )),
      );
    });

    test('is correctly converted with properties "phoneNumber" and "state"', () {
      final json = {
        'recipient': 'aRecipient',
        'deliveryBoxId': 'aDeliveryBoxId',
        'userId': 'anUserId',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'aCountry',
        'phoneNumber': 'aPhoneNumber',
        'state': 'aState',
      };
      expect(
        DeliveryBoxAddress.fromJson(json),
        equals(const DeliveryBoxAddress(
          recipient: 'aRecipient',
          deliveryBoxId: 'aDeliveryBoxId',
          userId: 'anUserId',
          zipCode: 'aZipCode',
          city: 'aCity',
          country: 'aCountry',
          phoneNumber: 'aPhoneNumber',
          state: 'aState',
        )),
      );
    });
  });
}
