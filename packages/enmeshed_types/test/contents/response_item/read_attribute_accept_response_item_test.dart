import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ReadAttributeAcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = ReadAttributeAcceptResponseItem(
        attributeId: 'anAttributeId',
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        thirdPartyAddress: 'aThirdParty',
      );
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({
          '@type': 'ReadAttributeAcceptResponseItem',
          'result': 'Accepted',
          'attributeId': 'anAttributeId',
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'thirdPartyAddress': 'aThirdParty',
        }),
      );
    });
  });

  group('ReadAttributeAcceptResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {
        'attributeId': 'anAttributeId',
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'thirdPartyAddress': 'aThirdParty',
      };
      expect(
        ReadAttributeAcceptResponseItem.fromJson(json),
        equals(const ReadAttributeAcceptResponseItem(
          attributeId: 'anAttributeId',
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          thirdPartyAddress: 'aThirdParty',
        )),
      );
    });
  });
}
