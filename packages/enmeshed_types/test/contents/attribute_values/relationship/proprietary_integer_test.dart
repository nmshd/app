import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryInteger toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryInteger(title: 'aTitle', value: 10);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryInteger', 'title': 'aTitle', 'value': 10}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryInteger(title: 'aTitle', description: 'aDescription', value: 10);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryInteger', 'title': 'aTitle', 'description': 'aDescription', 'value': 10}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryInteger(title: 'aTitle', valueHintsOverride: ValueHints(), value: 10);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryInteger', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryInteger(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: 10,
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryInteger',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 10,
        }),
      );
    });
  });

  group('ProprietaryInteger fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 10};
      expect(
        ProprietaryInteger.fromJson(json),
        equals(const ProprietaryInteger(title: 'aTitle', value: 10)),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 10};
      expect(
        ProprietaryInteger.fromJson(json),
        equals(const ProprietaryInteger(title: 'aTitle', description: 'aDescription', value: 10)),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10};
      expect(
        ProprietaryInteger.fromJson(json),
        equals(const ProprietaryInteger(title: 'aTitle', valueHintsOverride: ValueHints(), value: 10)),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10};
      expect(
        ProprietaryInteger.fromJson(json),
        equals(const ProprietaryInteger(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 10)),
      );
    });
  });
}
