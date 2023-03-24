import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Delivery Box Address to json', () {
    test('valid DeliveryBoxAddress', () {
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

    test('valid DeliveryBoxAddress with phoneNumber', () {
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

    test('valid DeliveryBoxAddress with state', () {
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

    test('valid DeliveryBoxAddress with phoneNumber and state', () {
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

  group('Delivery Box Address from json', () {
    test('valid DeliveryBoxAddress', () {
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

    test('valid DeliveryBoxAddress with phoneNumber', () {
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

    test('valid DeliveryBoxAddress with state', () {
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

    test('valid DeliveryBoxAddress with phoneNumber and state', () {
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
