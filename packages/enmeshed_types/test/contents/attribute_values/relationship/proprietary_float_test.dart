import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryFloat toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryFloat(title: 'aTitle', value: 10.5);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryFloat', 'title': 'aTitle', 'value': 10.5}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryFloat(title: 'aTitle', description: 'aDescription', value: 10.5);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryFloat', 'title': 'aTitle', 'description': 'aDescription', 'value': 10.5}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryFloat(title: 'aTitle', valueHintsOverride: ValueHints(), value: 10.5);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryFloat', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10.5}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryFloat(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: 10.5,
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryFloat',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 10.5,
        }),
      );
    });
  });

  group('ProprietaryFloat fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 10.5};
      expect(
        ProprietaryFloat.fromJson(json),
        equals(const ProprietaryFloat(title: 'aTitle', value: 10.5)),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 10.5};
      expect(
        ProprietaryFloat.fromJson(json),
        equals(const ProprietaryFloat(title: 'aTitle', description: 'aDescription', value: 10.5)),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10.5};
      expect(
        ProprietaryFloat.fromJson(json),
        equals(const ProprietaryFloat(title: 'aTitle', valueHintsOverride: ValueHints(), value: 10.5)),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10.5};
      expect(
        ProprietaryFloat.fromJson(json),
        equals(const ProprietaryFloat(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 10.5)),
      );
    });
  });
}
