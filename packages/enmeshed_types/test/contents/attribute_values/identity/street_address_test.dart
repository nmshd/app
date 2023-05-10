import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('StreetAddressAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = StreetAddressAttributeValue(
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
          'houseNo': 'aHouseNumber',
          'zipCode': 'aZipCode',
          'city': 'aCity',
          'country': 'aCountry',
          'state': 'aState',
        }),
      );
    });
  });

  group('StreetAddressAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {
        'recipient': 'aRecipient',
        'street': 'aStreet',
        'houseNo': 'aHouseNumber',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'aCountry',
        'state': 'aState',
      };
      expect(
        StreetAddressAttributeValue.fromJson(json),
        equals(const StreetAddressAttributeValue(
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
