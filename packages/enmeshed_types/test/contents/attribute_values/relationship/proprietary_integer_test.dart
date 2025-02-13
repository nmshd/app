import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryIntegerAttributeValue toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryIntegerAttributeValue(title: 'aTitle', value: 10);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(relationshipJson, equals({'@type': 'ProprietaryInteger', 'title': 'aTitle', 'value': 10}));
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryIntegerAttributeValue(title: 'aTitle', description: 'aDescription', value: 10);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(relationshipJson, equals({'@type': 'ProprietaryInteger', 'title': 'aTitle', 'description': 'aDescription', 'value': 10}));
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryIntegerAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 10);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryInteger', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryIntegerAttributeValue(
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

  group('ProprietaryIntegerAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 10};
      expect(ProprietaryIntegerAttributeValue.fromJson(json), equals(const ProprietaryIntegerAttributeValue(title: 'aTitle', value: 10)));
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 10};
      expect(
        ProprietaryIntegerAttributeValue.fromJson(json),
        equals(const ProprietaryIntegerAttributeValue(title: 'aTitle', description: 'aDescription', value: 10)),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10};
      expect(
        ProprietaryIntegerAttributeValue.fromJson(json),
        equals(const ProprietaryIntegerAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 10)),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10};
      expect(
        ProprietaryIntegerAttributeValue.fromJson(json),
        equals(const ProprietaryIntegerAttributeValue(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 10)),
      );
    });
  });
}
