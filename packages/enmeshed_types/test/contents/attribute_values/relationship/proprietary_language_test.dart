import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryLanguage toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryLanguage(title: 'aTitle', value: 'aLanguage');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryLanguage', 'title': 'aTitle', 'value': 'aLanguage'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryLanguage(title: 'aTitle', description: 'aDescription', value: 'aLanguage');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryLanguage', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aLanguage'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryLanguage(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aLanguage');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryLanguage', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aLanguage'}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
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

  group('ProprietaryLanguage fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 'aLanguage'};
      expect(
        ProprietaryLanguage.fromJson(json),
        equals(const ProprietaryLanguage(title: 'aTitle', value: 'aLanguage')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aLanguage'};
      expect(
        ProprietaryLanguage.fromJson(json),
        equals(const ProprietaryLanguage(title: 'aTitle', description: 'aDescription', value: 'aLanguage')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aLanguage'};
      expect(
        ProprietaryLanguage.fromJson(json),
        equals(const ProprietaryLanguage(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aLanguage')),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aLanguage'};
      expect(
        ProprietaryLanguage.fromJson(json),
        equals(const ProprietaryLanguage(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'aLanguage')),
      );
    });
  });
}
