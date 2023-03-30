import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryCountry toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryCountry(title: 'aTitle', value: 'aCountry');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryCountry', 'title': 'aTitle', 'value': 'aCountry'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryCountry(title: 'aTitle', description: 'aDescription', value: 'aCountry');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryCountry', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aCountry'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryCountry(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aCountry');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryCountry', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aCountry'}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
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

  group('ProprietaryCountry fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 'aCountry'};
      expect(
        ProprietaryCountry.fromJson(json),
        equals(const ProprietaryCountry(title: 'aTitle', value: 'aCountry')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aCountry'};
      expect(
        ProprietaryCountry.fromJson(json),
        equals(const ProprietaryCountry(title: 'aTitle', description: 'aDescription', value: 'aCountry')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aCountry'};
      expect(
        ProprietaryCountry.fromJson(json),
        equals(const ProprietaryCountry(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aCountry')),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aCountry'};
      expect(
        ProprietaryCountry.fromJson(json),
        equals(const ProprietaryCountry(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'aCountry')),
      );
    });
  });
}
