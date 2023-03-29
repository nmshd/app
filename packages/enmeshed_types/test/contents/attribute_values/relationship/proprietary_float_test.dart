import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary Float to json', () {
    test('valid ProprietaryFloat', () {
      const relationshipAttributeValue = ProprietaryFloat(title: 'aTitle', value: 10.5);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryFloat', 'title': 'aTitle', 'value': 10.5}),
      );
    });

    test('valid ProprietaryFloat with description', () {
      const relationshipAttributeValue = ProprietaryFloat(title: 'aTitle', description: 'aDescription', value: 10.5);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryFloat', 'title': 'aTitle', 'description': 'aDescription', 'value': 10.5}),
      );
    });

    test('valid ProprietaryFloat with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryFloat(title: 'aTitle', valueHintsOverride: ValueHints(), value: 10.5);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryFloat', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10.5}),
      );
    });

    test('valid ProprietaryFloat with description and valueHintsOverride', () {
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

  group('Proprietary Float from json', () {
    test('valid ProprietaryFloat', () {
      final json = {'title': 'aTitle', 'value': 10.5};
      expect(
        ProprietaryFloat.fromJson(json),
        equals(const ProprietaryFloat(title: 'aTitle', value: 10.5)),
      );
    });

    test('valid ProprietaryFloat with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 10.5};
      expect(
        ProprietaryFloat.fromJson(json),
        equals(const ProprietaryFloat(title: 'aTitle', description: 'aDescription', value: 10.5)),
      );
    });

    test('valid ProprietaryFloat with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10.5};
      expect(
        ProprietaryFloat.fromJson(json),
        equals(const ProprietaryFloat(title: 'aTitle', valueHintsOverride: ValueHints(), value: 10.5)),
      );
    });
    test('valid ProprietaryFloat description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10.5};
      expect(
        ProprietaryFloat.fromJson(json),
        equals(const ProprietaryFloat(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 10.5)),
      );
    });
  });
}
