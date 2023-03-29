import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary JSON to json', () {
    test('valid ProprietaryJSON', () {
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

    test('valid ProprietaryJSON with description', () {
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

  group('Proprietary JSON from json', () {
    test('valid ProprietaryJSON', () {
      final json = {
        'title': 'aTitle',
        'value': {'value': 'aValue'},
      };
      expect(
        ProprietaryJSON.fromJson(json),
        equals(const ProprietaryJSON(title: 'aTitle', value: {'value': 'aValue'})),
      );
    });

    test('valid ProprietaryJSON with description', () {
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
