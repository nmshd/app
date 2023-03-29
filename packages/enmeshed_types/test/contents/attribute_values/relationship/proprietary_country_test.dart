import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary Country to json', () {
    test('valid ProprietaryCountry', () {
      const relationshipAttributeValue = ProprietaryCountry(title: 'aTitle', value: 'aCountry');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryCountry', 'title': 'aTitle', 'value': 'aCountry'}),
      );
    });

    test('valid ProprietaryCountry with description', () {
      const relationshipAttributeValue = ProprietaryCountry(title: 'aTitle', description: 'aDescription', value: 'aCountry');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryCountry', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aCountry'}),
      );
    });

    test('valid ProprietaryCountry with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryCountry(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aCountry');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryCountry', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aCountry'}),
      );
    });

    test('valid ProprietaryCountry with description and valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryCountry(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: 'aCountry',
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryCountry',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 'aCountry',
        }),
      );
    });
  });

  group('Proprietary Country from json', () {
    test('valid ProprietaryCountry', () {
      final json = {'title': 'aTitle', 'value': 'aCountry'};
      expect(
        ProprietaryCountry.fromJson(json),
        equals(const ProprietaryCountry(title: 'aTitle', value: 'aCountry')),
      );
    });

    test('valid ProprietaryCountry with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aCountry'};
      expect(
        ProprietaryCountry.fromJson(json),
        equals(const ProprietaryCountry(title: 'aTitle', description: 'aDescription', value: 'aCountry')),
      );
    });

    test('valid ProprietaryCountry with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aCountry'};
      expect(
        ProprietaryCountry.fromJson(json),
        equals(const ProprietaryCountry(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aCountry')),
      );
    });
    test('valid ProprietaryCountry description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aCountry'};
      expect(
        ProprietaryCountry.fromJson(json),
        equals(const ProprietaryCountry(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'aCountry')),
      );
    });
  });
}
