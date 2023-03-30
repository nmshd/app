import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryURL toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryURL(title: 'aTitle', value: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryURL', 'title': 'aTitle', 'value': 'www.test.com'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryURL(title: 'aTitle', description: 'aDescription', value: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryURL', 'title': 'aTitle', 'description': 'aDescription', 'value': 'www.test.com'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryURL(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryURL', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'www.test.com'}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryURL(
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

  group('ProprietaryURL fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 'www.test.com'};
      expect(
        ProprietaryURL.fromJson(json),
        equals(const ProprietaryURL(title: 'aTitle', value: 'www.test.com')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'www.test.com'};
      expect(
        ProprietaryURL.fromJson(json),
        equals(const ProprietaryURL(title: 'aTitle', description: 'aDescription', value: 'www.test.com')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'www.test.com'};
      expect(
        ProprietaryURL.fromJson(json),
        equals(const ProprietaryURL(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'www.test.com')),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'www.test.com'};
      expect(
        ProprietaryURL.fromJson(json),
        equals(const ProprietaryURL(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'www.test.com')),
      );
    });
  });
}
