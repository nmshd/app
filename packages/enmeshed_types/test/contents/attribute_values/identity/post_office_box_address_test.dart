import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('PostOfficeBoxAddress toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = PostOfficeBoxAddress(
        recipient: 'aRecipient',
        boxId: 'aBoxId',
        zipCode: 'aZipCode',
        city: 'aCity',
        country: 'aCountry',
      );
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'PostOfficeBoxAddress',
          'recipient': 'aRecipient',
          'boxId': 'aBoxId',
          'zipCode': 'aZipCode',
          'city': 'aCity',
          'country': 'aCountry',
        }),
      );
    });

    test('is correctly converted with property "state"', () {
      const identityAttributeValue = PostOfficeBoxAddress(
        recipient: 'aRecipient',
        boxId: 'aBoxId',
        zipCode: 'aZipCode',
        city: 'aCity',
        country: 'aCountry',
        state: 'aState',
      );
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'PostOfficeBoxAddress',
          'recipient': 'aRecipient',
          'boxId': 'aBoxId',
          'zipCode': 'aZipCode',
          'city': 'aCity',
          'country': 'aCountry',
          'state': 'aState',
        }),
      );
    });
  });

  group('PostOfficeBoxAddress fromJson', () {
    test('is correctly converted', () {
      final json = {
        'recipient': 'aRecipient',
        'boxId': 'aBoxId',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'aCountry',
      };
      expect(
        PostOfficeBoxAddress.fromJson(json),
        equals(const PostOfficeBoxAddress(
          recipient: 'aRecipient',
          boxId: 'aBoxId',
          zipCode: 'aZipCode',
          city: 'aCity',
          country: 'aCountry',
        )),
      );
    });

    test('is correctly converted with property "state"', () {
      final json = {
        'recipient': 'aRecipient',
        'boxId': 'aBoxId',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'aCountry',
        'state': 'aState',
      };
      expect(
        PostOfficeBoxAddress.fromJson(json),
        equals(const PostOfficeBoxAddress(
          recipient: 'aRecipient',
          boxId: 'aBoxId',
          zipCode: 'aZipCode',
          city: 'aCity',
          country: 'aCountry',
          state: 'aState',
        )),
      );
    });
  });
}
