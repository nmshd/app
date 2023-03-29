import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary Boolean to json', () {
    test('valid ProprietaryBoolean', () {
      const relationshipAttributeValue = ProprietaryBoolean(title: 'aTitle', value: true);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryBoolean', 'title': 'aTitle', 'value': true}),
      );
    });

    test('valid ProprietaryBoolean with description', () {
      const relationshipAttributeValue = ProprietaryBoolean(title: 'aTitle', description: 'aDescription', value: true);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryBoolean', 'title': 'aTitle', 'description': 'aDescription', 'value': true}),
      );
    });

    test('valid ProprietaryBoolean with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryBoolean(title: 'aTitle', valueHintsOverride: ValueHints(), value: true);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryBoolean', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': true}),
      );
    });

    test('valid ProprietaryBoolean with description and valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryBoolean(
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

  group('Proprietary Boolean from json', () {
    test('valid ProprietaryBoolean', () {
      final json = {'title': 'aTitle', 'value': true};
      expect(
        ProprietaryBoolean.fromJson(json),
        equals(const ProprietaryBoolean(title: 'aTitle', value: true)),
      );
    });

    test('valid ProprietaryBoolean with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': true};
      expect(
        ProprietaryBoolean.fromJson(json),
        equals(const ProprietaryBoolean(title: 'aTitle', description: 'aDescription', value: true)),
      );
    });

    test('valid ProprietaryBoolean with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': true};
      expect(
        ProprietaryBoolean.fromJson(json),
        equals(const ProprietaryBoolean(title: 'aTitle', valueHintsOverride: ValueHints(), value: true)),
      );
    });
    test('valid ProprietaryBoolean description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': true};
      expect(
        ProprietaryBoolean.fromJson(json),
        equals(const ProprietaryBoolean(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: true)),
      );
    });
  });
}
