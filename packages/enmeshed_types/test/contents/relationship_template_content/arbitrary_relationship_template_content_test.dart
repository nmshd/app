import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ArbitraryRelationshipTemplateContent toJson', () {
    test('is correctly converted', () {
      final relationshipTemplateContent = ArbitraryRelationshipTemplateContent(const {'key': 'value'});
      final relationshipTemplateContentJson = relationshipTemplateContent.toJson();
      expect(
        relationshipTemplateContentJson,
        equals({
          '@type': 'ArbitraryRelationshipTemplateContent',
          'value': {'key': 'value'},
        }),
      );
    });
  });

  group('ArbitraryRelationshipTemplateContent fromJson', () {
    test('is correctly converted', () {
      final json = {
        '@type': 'ArbitraryRelationshipTemplateContent',
        'value': {'key': 'value'},
      };
      expect(ArbitraryRelationshipTemplateContent.fromJson(json), equals(ArbitraryRelationshipTemplateContent(const {'key': 'value'})));
    });
  });
}
