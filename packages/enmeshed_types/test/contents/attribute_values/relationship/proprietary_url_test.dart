import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryURLAttributeValue toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryURLAttributeValue(title: 'aTitle', value: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryURL', 'title': 'aTitle', 'value': 'www.test.com'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryURLAttributeValue(title: 'aTitle', description: 'aDescription', value: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryURL', 'title': 'aTitle', 'description': 'aDescription', 'value': 'www.test.com'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryURLAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryURL', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'www.test.com'}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryURLAttributeValue(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: 'www.test.com',
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryURL',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 'www.test.com',
        }),
      );
    });
  });

  group('ProprietaryURLAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 'www.test.com'};
      expect(
        ProprietaryURLAttributeValue.fromJson(json),
        equals(const ProprietaryURLAttributeValue(title: 'aTitle', value: 'www.test.com')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'www.test.com'};
      expect(
        ProprietaryURLAttributeValue.fromJson(json),
        equals(const ProprietaryURLAttributeValue(title: 'aTitle', description: 'aDescription', value: 'www.test.com')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'www.test.com'};
      expect(
        ProprietaryURLAttributeValue.fromJson(json),
        equals(const ProprietaryURLAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'www.test.com')),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'www.test.com'};
      expect(
        ProprietaryURLAttributeValue.fromJson(json),
        equals(const ProprietaryURLAttributeValue(
          title: 'aTitle',
          description: 'aDescription',
          valueHintsOverride: ValueHints(),
          value: 'www.test.com',
        )),
      );
    });
  });
}
