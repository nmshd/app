import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary Integer to json', () {
    test('valid ProprietaryInteger', () {
      const relationshipAttributeValue = ProprietaryInteger(title: 'aTitle', value: 10);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryInteger', 'title': 'aTitle', 'value': 10}),
      );
    });

    test('valid ProprietaryInteger with description', () {
      const relationshipAttributeValue = ProprietaryInteger(title: 'aTitle', description: 'aDescription', value: 10);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryInteger', 'title': 'aTitle', 'description': 'aDescription', 'value': 10}),
      );
    });

    test('valid ProprietaryInteger with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryInteger(title: 'aTitle', valueHintsOverride: ValueHints(), value: 10);
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryInteger', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10}),
      );
    });

    test('valid ProprietaryInteger with description and valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryInteger(
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

  group('Proprietary Integer from json', () {
    test('valid ProprietaryInteger', () {
      final json = {'title': 'aTitle', 'value': 10};
      expect(
        ProprietaryInteger.fromJson(json),
        equals(const ProprietaryInteger(title: 'aTitle', value: 10)),
      );
    });

    test('valid ProprietaryInteger with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 10};
      expect(
        ProprietaryInteger.fromJson(json),
        equals(const ProprietaryInteger(title: 'aTitle', description: 'aDescription', value: 10)),
      );
    });

    test('valid ProprietaryInteger with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10};
      expect(
        ProprietaryInteger.fromJson(json),
        equals(const ProprietaryInteger(title: 'aTitle', valueHintsOverride: ValueHints(), value: 10)),
      );
    });
    test('valid ProprietaryInteger description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 10};
      expect(
        ProprietaryInteger.fromJson(json),
        equals(const ProprietaryInteger(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 10)),
      );
    });
  });
}
