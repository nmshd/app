import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const attributeCreationHints = RelationshipAttributeCreationHints(
    title: 'aTitle',
    valueType: 'aValueType',
    confidentiality: 'public',
  );
  group('Relationship Attribute Query to json', () {
    test('valid RelationshipAttributeQuery', () {
      const relationshipAttributeQuery = RelationshipAttributeQuery(
        key: 'ProprietaryInteger',
        owner: 'anOwner',
        attributeCreationHints: attributeCreationHints,
      );
      final relationshipJson = relationshipAttributeQuery.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'RelationshipAttributeQuery',
          'key': 'ProprietaryInteger',
          'owner': 'anOwner',
          'attributeCreationHints': attributeCreationHints.toJson(),
        }),
      );
    });

    test('valid RelationshipAttributeQuery with validFrom and validTo', () {
      const relationshipAttributeQuery = RelationshipAttributeQuery(
        key: 'ProprietaryInteger',
        owner: 'anOwner',
        attributeCreationHints: attributeCreationHints,
        validFrom: '1970',
        validTo: '1980',
      );
      final relationshipJson = relationshipAttributeQuery.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'RelationshipAttributeQuery',
          'key': 'ProprietaryInteger',
          'owner': 'anOwner',
          'attributeCreationHints': attributeCreationHints.toJson(),
          'validFrom': '1970',
          'validTo': '1980',
        }),
      );
    });
  });

  group('Relationship Attribute Query from json', () {
    test('valid RelationshipAttributeQuery', () {
      final json = {
        'key': 'ProprietaryInteger',
        'owner': 'anOwner',
        'attributeCreationHints': attributeCreationHints.toJson(),
      };
      expect(
        RelationshipAttributeQuery.fromJson(json),
        equals(const RelationshipAttributeQuery(
          key: 'ProprietaryInteger',
          owner: 'anOwner',
          attributeCreationHints: attributeCreationHints,
        )),
      );
    });

    test('valid RelationshipAttributeQuery with validFrom and validTo', () {
      final json = {
        'key': 'ProprietaryInteger',
        'owner': 'anOwner',
        'attributeCreationHints': attributeCreationHints.toJson(),
        'validFrom': '1970',
        'validTo': '1980',
      };
      expect(
        RelationshipAttributeQuery.fromJson(json),
        equals(const RelationshipAttributeQuery(
          key: 'ProprietaryInteger',
          owner: 'anOwner',
          attributeCreationHints: attributeCreationHints,
          validFrom: '1970',
          validTo: '1980',
        )),
      );
    });
  });
}
