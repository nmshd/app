import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary Language to json', () {
    test('valid ProprietaryLanguage', () {
      const relationshipAttributeValue = ProprietaryLanguage(title: 'aTitle', value: 'aLanguage');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryLanguage', 'title': 'aTitle', 'value': 'aLanguage'}),
      );
    });

    test('valid ProprietaryLanguage with description', () {
      const relationshipAttributeValue = ProprietaryLanguage(title: 'aTitle', description: 'aDescription', value: 'aLanguage');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryLanguage', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aLanguage'}),
      );
    });

    test('valid ProprietaryLanguage with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryLanguage(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aLanguage');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryLanguage', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aLanguage'}),
      );
    });

    test('valid ProprietaryLanguage with description and valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryLanguage(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: 'aLanguage',
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryLanguage',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 'aLanguage',
        }),
      );
    });
  });

  group('Proprietary Language from json', () {
    test('valid ProprietaryLanguage', () {
      final json = {'title': 'aTitle', 'value': 'aLanguage'};
      expect(
        ProprietaryLanguage.fromJson(json),
        equals(const ProprietaryLanguage(title: 'aTitle', value: 'aLanguage')),
      );
    });

    test('valid ProprietaryLanguage with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aLanguage'};
      expect(
        ProprietaryLanguage.fromJson(json),
        equals(const ProprietaryLanguage(title: 'aTitle', description: 'aDescription', value: 'aLanguage')),
      );
    });

    test('valid ProprietaryLanguage with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aLanguage'};
      expect(
        ProprietaryLanguage.fromJson(json),
        equals(const ProprietaryLanguage(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aLanguage')),
      );
    });
    test('valid ProprietaryLanguage description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aLanguage'};
      expect(
        ProprietaryLanguage.fromJson(json),
        equals(const ProprietaryLanguage(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'aLanguage')),
      );
    });
  });
}
