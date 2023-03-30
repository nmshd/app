import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Attribute Query from json correctly', () {
    test('AttributeQuery.fromJson should parse valid IdentityAttributeQuery correctly', () {
      final identityAttributeJson = {
        '@type': 'IdentityAttributeQuery',
        'valueType': 'StreetAddress',
      };
      final identityAttributeQuery = AttributeQuery.fromJson(identityAttributeJson);
      expect(identityAttributeQuery, isA<IdentityAttributeQuery>());
    });

    test('AttributeQuery.fromJson should parse valid RelationshipAttributeQuery correctly', () {
      const attributeCreationHints = RelationshipAttributeCreationHints(
        title: 'aTitle',
        valueType: 'aValueType',
        confidentiality: 'public',
      );

      final relationshipAttributeJson = {
        '@type': 'RelationshipAttributeQuery',
        'key': 'ProprietaryInteger',
        'owner': 'anAddress',
        'attributeCreationHints': attributeCreationHints.toJson(),
      };
      final relationshipAttributeQuery = AttributeQuery.fromJson(relationshipAttributeJson);
      expect(relationshipAttributeQuery, isA<RelationshipAttributeQuery>());
    });

    test('AttributeQuery.fromJson should parse valid ThirdPartyRelationshipAttributeQuery correctly', () {
      final thirdPartyRelationshipAttributeJson = {
        '@type': 'ThirdPartyRelationshipAttributeQuery',
        'key': 'ProprietaryInteger',
        'owner': 'anAddress',
        'thirdParty': ['aThirdPartyAddress'],
      };
      final thirdPartyRelationshipAttributeQuery = AttributeQuery.fromJson(thirdPartyRelationshipAttributeJson);
      expect(thirdPartyRelationshipAttributeQuery, isA<ThirdPartyRelationshipAttributeQuery>());
    });
  });

  group('Attribute Query from json with exception', () {
    test('AttributeQuery.fromJson with wrong @type should throw an Exception', () {
      final invalidJson = {'@type': 'wrongType'};

      expect(() => AttributeQuery.fromJson(invalidJson), throwsA(isA<Exception>()));
    });
  });

  group('Attribute Query to json', () {
    test('valid AttributeQuery', () {
      const mockAttributeQuery = MockAttributeQuery();

      expect(mockAttributeQuery.toJson(), equals(<String, dynamic>{}));
    });
    test('valid AttributeQuery with validFrom and validTo', () {
      const mockAttributeQuery = MockAttributeQuery(validFrom: '1970', validTo: '1980');

      final attributeQueryJson = {'validFrom': '1970', 'validTo': '1980'};

      expect(mockAttributeQuery.toJson(), equals(attributeQueryJson));
    });
  });
}

class MockAttributeQuery extends AttributeQuery {
  const MockAttributeQuery({
    super.validFrom,
    super.validTo,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
    };
  }
}
