import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ResponseItem fromJson', () {
    test('parsed valid ResponseItemGroup', () {
      final responseItemGroupJson = {'@type': 'ResponseItemGroup', 'result': 'Accepted', 'items': []};
      final responseItemGroup = ResponseItem.fromJson(responseItemGroupJson);
      expect(responseItemGroup, isA<ResponseItemGroup>());
    });

    test('parsed valid ResponseItemDerivation', () {
      final responseItemJson = {
        '@type': 'ReadAttributeAcceptResponseItem',
        'attributeId': 'anAttributeId',
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'thirdPartyAddress': 'aThirdParty',
      };
      final responseItemDerivation = ResponseItem.fromJson(responseItemJson);
      expect(responseItemDerivation, isA<ResponseItemDerivation>());
    });
  });

  group('ResponseItem fromJson with exception', () {
    test('throws exception when @type is missing', () {
      final json = {'result': 'Accepted'};
      expect(() => ResponseItem.fromJson(json), throwsA(isA<Exception>()));
    });

    test('throws exception when type is unknown', () {
      final json = {'@type': 'UnknownType', 'result': 'Accepted'};
      expect(() => ResponseItem.fromJson(json), throwsA(isA<Exception>()));
    });
  });
}
