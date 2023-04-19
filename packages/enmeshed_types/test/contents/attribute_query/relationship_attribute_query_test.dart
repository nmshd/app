import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const attributeCreationHints = RelationshipAttributeCreationHints(
    title: 'aTitle',
    valueType: 'aValueType',
    confidentiality: 'public',
  );
  group('RelationshipAttributeQuery toJson', () {
    test('is correctly converted', () {
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

    test('is correctly converted with properties "validFrom" and "validTo"', () {
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

  group('RelationshipAttributeQuery fromJson', () {
    test('is correctly converted', () {
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

    test('is correctly converted with properties "validFrom" and "validTo"', () {
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
