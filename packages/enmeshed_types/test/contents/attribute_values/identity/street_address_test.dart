import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Street Address to json', () {
    test('valid StreetAddress', () {
      const identityAttributeValue = StreetAddress(
        recipient: 'aRecipient',
        street: 'aStreet',
        houseNumber: 'aHouseNumber',
        zipCode: 'aZipCode',
        city: 'aCity',
        country: 'aCountry',
        state: 'aState',
      );
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'StreetAddress',
          'recipient': 'aRecipient',
          'street': 'aStreet',
          'houseNumber': 'aHouseNumber',
          'zipCode': 'aZipCode',
          'city': 'aCity',
          'country': 'aCountry',
          'state': 'aState',
        }),
      );
    });
  });

  group('Street Address from json', () {
    test('valid StreetAddress', () {
      final json = {
        'recipient': 'aRecipient',
        'street': 'aStreet',
        'houseNumber': 'aHouseNumber',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'aCountry',
        'state': 'aState',
      };
      expect(
        StreetAddress.fromJson(json),
        equals(const StreetAddress(
          recipient: 'aRecipient',
          street: 'aStreet',
          houseNumber: 'aHouseNumber',
          zipCode: 'aZipCode',
          city: 'aCity',
          country: 'aCountry',
          state: 'aState',
        )),
      );
    });
  });
}
