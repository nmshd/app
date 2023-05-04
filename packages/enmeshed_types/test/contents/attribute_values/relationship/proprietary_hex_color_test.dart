import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryHEXColor toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryHEXColorAttributeValue(title: 'aTitle', value: 'aHEXColor');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryHEXColor', 'title': 'aTitle', 'value': 'aHEXColor'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryHEXColorAttributeValue(title: 'aTitle', description: 'aDescription', value: 'aHEXColor');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryHEXColor', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aHEXColor'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryHEXColorAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aHEXColor');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryHEXColor', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aHEXColor'}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryHEXColorAttributeValue(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: 'aHEXColor',
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryHEXColor',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 'aHEXColor',
        }),
      );
    });
  });

  group('ProprietaryHEXColor fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 'aHEXColor'};
      expect(
        ProprietaryHEXColorAttributeValue.fromJson(json),
        equals(const ProprietaryHEXColorAttributeValue(title: 'aTitle', value: 'aHEXColor')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aHEXColor'};
      expect(
        ProprietaryHEXColorAttributeValue.fromJson(json),
        equals(const ProprietaryHEXColorAttributeValue(title: 'aTitle', description: 'aDescription', value: 'aHEXColor')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aHEXColor'};
      expect(
        ProprietaryHEXColorAttributeValue.fromJson(json),
        equals(const ProprietaryHEXColorAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aHEXColor')),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aHEXColor'};
      expect(
        ProprietaryHEXColorAttributeValue.fromJson(json),
        equals(const ProprietaryHEXColorAttributeValue(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'aHEXColor')),
      );
    });
  });
}
