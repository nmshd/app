import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryBoolean toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryBooleanAttributeValue(title: 'aTitle', value: true);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryBoolean', 'title': 'aTitle', 'value': true}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryBooleanAttributeValue(title: 'aTitle', description: 'aDescription', value: true);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryBoolean', 'title': 'aTitle', 'description': 'aDescription', 'value': true}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryBooleanAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: true);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryBoolean', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': true}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryBooleanAttributeValue(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: true,
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryBoolean',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': true,
        }),
      );
    });
  });

  group('ProprietaryBoolean fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': true};
      expect(
        ProprietaryBooleanAttributeValue.fromJson(json),
        equals(const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true)),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': true};
      expect(
        ProprietaryBooleanAttributeValue.fromJson(json),
        equals(const ProprietaryBooleanAttributeValue(title: 'aTitle', description: 'aDescription', value: true)),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': true};
      expect(
        ProprietaryBooleanAttributeValue.fromJson(json),
        equals(const ProprietaryBooleanAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: true)),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': true};
      expect(
        ProprietaryBooleanAttributeValue.fromJson(json),
        equals(const ProprietaryBooleanAttributeValue(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: true)),
      );
    });
  });
}
