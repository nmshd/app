import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryJSONAttributeValue toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryJSONAttributeValue(title: 'aTitle', value: {'value': 'aValue'});
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
      const relationshipAttributeValue = ProprietaryJSONAttributeValue(title: 'aTitle', description: 'aDescription', value: {'value': 'aValue'});
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

  group('ProprietaryJSONAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {
        'title': 'aTitle',
        'value': {'value': 'aValue'},
      };
      expect(
        ProprietaryJSONAttributeValue.fromJson(json),
        equals(const ProprietaryJSONAttributeValue(title: 'aTitle', value: {'value': 'aValue'})),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'title': 'aTitle',
        'description': 'aDescription',
        'value': {'value': 'aValue'},
      };
      expect(
        ProprietaryJSONAttributeValue.fromJson(json),
        equals(const ProprietaryJSONAttributeValue(title: 'aTitle', description: 'aDescription', value: {'value': 'aValue'})),
      );
    });
  });
}
