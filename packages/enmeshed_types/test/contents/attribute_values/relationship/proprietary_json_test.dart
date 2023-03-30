import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryJSON toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryJSON(title: 'aTitle', value: {'value': 'aValue'});
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryJSON',
          'title': 'aTitle',
          'value': {'value': 'aValue'},
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryJSON(title: 'aTitle', description: 'aDescription', value: {'value': 'aValue'});
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryJSON',
          'title': 'aTitle',
          'description': 'aDescription',
          'value': {'value': 'aValue'},
        }),
      );
    });
  });

  group('ProprietaryJSON fromJson', () {
    test('is correctly converted', () {
      final json = {
        'title': 'aTitle',
        'value': {'value': 'aValue'},
      };
      expect(
        ProprietaryJSON.fromJson(json),
        equals(const ProprietaryJSON(title: 'aTitle', value: {'value': 'aValue'})),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'title': 'aTitle',
        'description': 'aDescription',
        'value': {'value': 'aValue'},
      };
      expect(
        ProprietaryJSON.fromJson(json),
        equals(const ProprietaryJSON(title: 'aTitle', description: 'aDescription', value: {'value': 'aValue'})),
      );
    });
  });
}
