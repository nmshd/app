import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const attributeCreationHints = RelationshipAttributeCreationHints(title: 'aTitle', valueType: 'aValueType', confidentiality: 'public');
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
  });

  group('RelationshipAttributeQuery fromJson', () {
    test('is correctly converted', () {
      final json = {'key': 'ProprietaryInteger', 'owner': 'anOwner', 'attributeCreationHints': attributeCreationHints.toJson()};
      expect(
        RelationshipAttributeQuery.fromJson(json),
        equals(const RelationshipAttributeQuery(key: 'ProprietaryInteger', owner: 'anOwner', attributeCreationHints: attributeCreationHints)),
      );
    });
  });
}
