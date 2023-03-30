import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryString toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryString(title: 'aTitle', value: 'aString');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryString', 'title': 'aTitle', 'value': 'aString'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryString(title: 'aTitle', description: 'aDescription', value: 'aString');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryString', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aString'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryString(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aString');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryString', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aString'}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryString(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: 'aString',
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryString',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 'aString',
        }),
      );
    });
  });

  group('ProprietaryString fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 'aString'};
      expect(
        ProprietaryString.fromJson(json),
        equals(const ProprietaryString(title: 'aTitle', value: 'aString')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aString'};
      expect(
        ProprietaryString.fromJson(json),
        equals(const ProprietaryString(title: 'aTitle', description: 'aDescription', value: 'aString')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aString'};
      expect(
        ProprietaryString.fromJson(json),
        equals(const ProprietaryString(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aString')),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aString'};
      expect(
        ProprietaryString.fromJson(json),
        equals(const ProprietaryString(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'aString')),
      );
    });
  });
}
