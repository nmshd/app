import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ArbitraryRelationshipCreationContent toJson', () {
    test('is correctly converted', () {
      final relationshipCreationContent = ArbitraryRelationshipCreationContent(const {'key': 'value'});
      final relationshipCreationContentJson = relationshipCreationContent.toJson();
      expect(
        relationshipCreationContentJson,
        equals({
          '@type': 'ArbitraryRelationshipCreationContent',
          'value': {'key': 'value'}
        }),
      );
    });
  });

  group('ArbitraryRelationshipCreationContent fromJson', () {
    test('is correctly converted', () {
      final json = {
        '@type': 'ArbitraryRelationshipCreationContent',
        'value': {'key': 'value'}
      };
      expect(
        RelationshipCreationContent.fromJson(json),
        equals(ArbitraryRelationshipCreationContent(const {'key': 'value'})),
      );
    });
  });
}
