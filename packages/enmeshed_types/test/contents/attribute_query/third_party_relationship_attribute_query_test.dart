import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ThirdPartyRelationshipAttributeQuery toJson', () {
    test('is correctly converted', () {
      const thirdPartyRelationshipAttributeQuery = ThirdPartyRelationshipAttributeQuery(
        key: 'ProprietaryInteger',
        owner: ThirdPartyRelationshipAttributeQueryOwner.thirdParty,
        thirdParty: ['anAddress'],
      );
      final relationshipJson = thirdPartyRelationshipAttributeQuery.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ThirdPartyRelationshipAttributeQuery',
          'key': 'ProprietaryInteger',
          'owner': 'thirdParty',
          'thirdParty': ['anAddress'],
        }),
      );
    });
  });

  group('ThirdPartyRelationshipAttributeQuery fromJson', () {
    test('is correctly converted', () {
      final json = {
        'key': 'ProprietaryInteger',
        'owner': 'thirdParty',
        'thirdParty': ['anAddress'],
      };
      expect(
        ThirdPartyRelationshipAttributeQuery.fromJson(json),
        equals(
          const ThirdPartyRelationshipAttributeQuery(
            key: 'ProprietaryInteger',
            owner: ThirdPartyRelationshipAttributeQueryOwner.thirdParty,
            thirdParty: ['anAddress'],
          ),
        ),
      );
    });
  });
}
