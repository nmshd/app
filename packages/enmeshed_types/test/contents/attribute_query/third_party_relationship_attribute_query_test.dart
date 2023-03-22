import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Third Party Relationship Attribute Query to json',
    () {
      test('valid ThirdPartyRelationshipAttributeQuery', () {
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

      test('valid ThirdPartyRelationshipAttributeQuery with validFrom and validTo', () {
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
    },
  );

  group('Third Party Relationship Attribute Query from json', () {
    test('valid ThirdPartyRelationshipAttributeQuery', () {
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

    test('valid ThirdPartyRelationshipAttributeQuery with validFrom and validTo', () {
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
