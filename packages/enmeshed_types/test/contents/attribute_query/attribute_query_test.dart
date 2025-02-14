import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AttributeQuery fromJson', () {
    test('parsed valid IdentityAttributeQuery', () {
      final identityAttributeJson = {'@type': 'IdentityAttributeQuery', 'valueType': 'StreetAddress'};
      final identityAttributeQuery = AttributeQuery.fromJson(identityAttributeJson);
      expect(identityAttributeQuery, isA<IdentityAttributeQuery>());
    });

    test('parsed valid RelationshipAttributeQuery', () {
      const attributeCreationHints = RelationshipAttributeCreationHints(title: 'aTitle', valueType: 'aValueType', confidentiality: 'public');

      final relationshipAttributeJson = {
        '@type': 'RelationshipAttributeQuery',
        'key': 'ProprietaryInteger',
        'owner': 'anAddress',
        'attributeCreationHints': attributeCreationHints.toJson(),
      };
      final relationshipAttributeQuery = AttributeQuery.fromJson(relationshipAttributeJson);
      expect(relationshipAttributeQuery, isA<RelationshipAttributeQuery>());
    });

    test('parsed valid ThirdPartyRelationshipAttributeQuery', () {
      final thirdPartyRelationshipAttributeJson = {
        '@type': 'ThirdPartyRelationshipAttributeQuery',
        'key': 'ProprietaryInteger',
        'owner': '',
        'thirdParty': ['aThirdPartyAddress'],
      };
      final thirdPartyRelationshipAttributeQuery = AttributeQuery.fromJson(thirdPartyRelationshipAttributeJson);
      expect(thirdPartyRelationshipAttributeQuery, isA<ThirdPartyRelationshipAttributeQuery>());
    });
  });

  group('AttributeQuery fromJson with wrong @type', () {
    test('throws an Exception', () {
      final invalidJson = {'@type': 'wrongType'};

      expect(() => AttributeQuery.fromJson(invalidJson), throwsA(isA<Exception>()));
    });
  });
}
