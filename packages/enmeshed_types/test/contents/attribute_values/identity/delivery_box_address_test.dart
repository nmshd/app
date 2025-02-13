import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('DeliveryBoxAddressAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = DeliveryBoxAddressAttributeValue(
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
      const identityAttributeValue = DeliveryBoxAddressAttributeValue(
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
      const identityAttributeValue = DeliveryBoxAddressAttributeValue(
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
      const identityAttributeValue = DeliveryBoxAddressAttributeValue(
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

  group('DeliveryBoxAddressAttributeValue fromJson', () {
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
        DeliveryBoxAddressAttributeValue.fromJson(json),
        equals(
          const DeliveryBoxAddressAttributeValue(
            recipient: 'aRecipient',
            deliveryBoxId: 'aDeliveryBoxId',
            userId: 'anUserId',
            zipCode: 'aZipCode',
            city: 'aCity',
            country: 'aCountry',
          ),
        ),
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
        DeliveryBoxAddressAttributeValue.fromJson(json),
        equals(
          const DeliveryBoxAddressAttributeValue(
            recipient: 'aRecipient',
            deliveryBoxId: 'aDeliveryBoxId',
            userId: 'anUserId',
            zipCode: 'aZipCode',
            city: 'aCity',
            country: 'aCountry',
            phoneNumber: 'aPhoneNumber',
          ),
        ),
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
        DeliveryBoxAddressAttributeValue.fromJson(json),
        equals(
          const DeliveryBoxAddressAttributeValue(
            recipient: 'aRecipient',
            deliveryBoxId: 'aDeliveryBoxId',
            userId: 'anUserId',
            zipCode: 'aZipCode',
            city: 'aCity',
            country: 'aCountry',
            state: 'aState',
          ),
        ),
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
        DeliveryBoxAddressAttributeValue.fromJson(json),
        equals(
          const DeliveryBoxAddressAttributeValue(
            recipient: 'aRecipient',
            deliveryBoxId: 'aDeliveryBoxId',
            userId: 'anUserId',
            zipCode: 'aZipCode',
            city: 'aCity',
            country: 'aCountry',
            phoneNumber: 'aPhoneNumber',
            state: 'aState',
          ),
        ),
      );
    });
  });
}
