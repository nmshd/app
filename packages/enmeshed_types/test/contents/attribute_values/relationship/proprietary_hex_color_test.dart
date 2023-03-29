import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary HEX Color to json', () {
    test('valid ProprietaryHEXColor', () {
      const relationshipAttributeValue = ProprietaryHEXColor(title: 'aTitle', value: 'aHEXColor');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryHEXColor', 'title': 'aTitle', 'value': 'aHEXColor'}),
      );
    });

    test('valid ProprietaryHEXColor with description', () {
      const relationshipAttributeValue = ProprietaryHEXColor(title: 'aTitle', description: 'aDescription', value: 'aHEXColor');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryHEXColor', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aHEXColor'}),
      );
    });

    test('valid ProprietaryHEXColor with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryHEXColor(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aHEXColor');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryHEXColor', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aHEXColor'}),
      );
    });

    test('valid ProprietaryHEXColor with description and valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryHEXColor(
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

  group('Proprietary HEX Color from json', () {
    test('valid ProprietaryHEXColor', () {
      final json = {'title': 'aTitle', 'value': 'aHEXColor'};
      expect(
        ProprietaryHEXColor.fromJson(json),
        equals(const ProprietaryHEXColor(title: 'aTitle', value: 'aHEXColor')),
      );
    });

    test('valid ProprietaryHEXColor with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aHEXColor'};
      expect(
        ProprietaryHEXColor.fromJson(json),
        equals(const ProprietaryHEXColor(title: 'aTitle', description: 'aDescription', value: 'aHEXColor')),
      );
    });

    test('valid ProprietaryHEXColor with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aHEXColor'};
      expect(
        ProprietaryHEXColor.fromJson(json),
        equals(const ProprietaryHEXColor(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aHEXColor')),
      );
    });
    test('valid ProprietaryHEXColor description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aHEXColor'};
      expect(
        ProprietaryHEXColor.fromJson(json),
        equals(const ProprietaryHEXColor(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'aHEXColor')),
      );
    });
  });
}
