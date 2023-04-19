import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ThirdPartyRelationshipAttributeQuery toJson', () {
    test('is correctly converted', () {
      const thirdPartyRelationshipAttributeQuery = ThirdPartyRelationshipAttributeQuery(
        key: 'ProprietaryInteger',
        owner: 'anOwner',
        thirdParty: ['anAddress'],
      );
      final relationshipJson = thirdPartyRelationshipAttributeQuery.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ThirdPartyRelationshipAttributeQuery',
          'key': 'ProprietaryInteger',
          'owner': 'anOwner',
          'thirdParty': ['anAddress'],
        }),
      );
    });

    test('is correctly converted with properties "validFrom" and "validTo"', () {
      const thirdPartyRelationshipAttributeQuery = ThirdPartyRelationshipAttributeQuery(
        key: 'ProprietaryInteger',
        owner: 'anOwner',
        thirdParty: ['anAddress'],
        validFrom: '1970',
        validTo: '1980',
      );
      final relationshipJson = thirdPartyRelationshipAttributeQuery.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ThirdPartyRelationshipAttributeQuery',
          'key': 'ProprietaryInteger',
          'owner': 'anOwner',
          'thirdParty': ['anAddress'],
          'validFrom': '1970',
          'validTo': '1980',
        }),
      );
    });
  });

  group('ThirdPartyRelationshipAttributeQuery fromJson', () {
    test('is correctly converted', () {
      final json = {
        'key': 'ProprietaryInteger',
        'owner': 'anOwner',
        'thirdParty': ['anAddress'],
      };
      expect(
        ThirdPartyRelationshipAttributeQuery.fromJson(json),
        equals(const ThirdPartyRelationshipAttributeQuery(
          key: 'ProprietaryInteger',
          owner: 'anOwner',
          thirdParty: ['anAddress'],
        )),
      );
    });

    test('is correctly converted with properties "validFrom" and "validTo"', () {
      final json = {
        'key': 'ProprietaryInteger',
        'owner': 'anOwner',
        'thirdParty': ['anAddress'],
        'validFrom': '1970',
        'validTo': '1980',
      };
      expect(
        ThirdPartyRelationshipAttributeQuery.fromJson(json),
        equals(const ThirdPartyRelationshipAttributeQuery(
          key: 'ProprietaryInteger',
          owner: 'anOwner',
          thirdParty: ['anAddress'],
          validFrom: '1970',
          validTo: '1980',
        )),
      );
    });
  });
}
