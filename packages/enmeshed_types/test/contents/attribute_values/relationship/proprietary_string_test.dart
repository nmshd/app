import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryStringAttributeValue toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryString', 'title': 'aTitle', 'value': 'aString'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryStringAttributeValue(title: 'aTitle', description: 'aDescription', value: 'aString');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryString', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aString'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryStringAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aString');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryString', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aString'}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryStringAttributeValue(
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

  group('ProprietaryStringAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 'aString'};
      expect(
        ProprietaryStringAttributeValue.fromJson(json),
        equals(const ProprietaryStringAttributeValue(title: 'aTitle', value: 'aString')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aString'};
      expect(
        ProprietaryStringAttributeValue.fromJson(json),
        equals(const ProprietaryStringAttributeValue(title: 'aTitle', description: 'aDescription', value: 'aString')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aString'};
      expect(
        ProprietaryStringAttributeValue.fromJson(json),
        equals(const ProprietaryStringAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aString')),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aString'};
      expect(
        ProprietaryStringAttributeValue.fromJson(json),
        equals(
          const ProprietaryStringAttributeValue(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'aString'),
        ),
      );
    });
  });
}
