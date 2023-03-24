import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Post Office Box Address to json', () {
    test('valid PostOfficeBoxAddress', () {
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

    test('valid PostOfficeBoxAddress with state', () {
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

  group('Post Office Box Address from json', () {
    test('valid PostOfficeBoxAddress', () {
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

    test('valid PostOfficeBoxAddress with state', () {
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
