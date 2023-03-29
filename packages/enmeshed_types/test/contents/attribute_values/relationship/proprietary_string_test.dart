import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary String to json', () {
    test('valid ProprietaryString', () {
      const relationshipAttributeValue = ProprietaryString(title: 'aTitle', value: 'aString');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryString', 'title': 'aTitle', 'value': 'aString'}),
      );
    });

    test('valid ProprietaryString with description', () {
      const relationshipAttributeValue = ProprietaryString(title: 'aTitle', description: 'aDescription', value: 'aString');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryString', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aString'}),
      );
    });

    test('valid ProprietaryString with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryString(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aString');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryString', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aString'}),
      );
    });

    test('valid ProprietaryString with description and valueHintsOverride', () {
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

  group('Proprietary String from json', () {
    test('valid ProprietaryString', () {
      final json = {'title': 'aTitle', 'value': 'aString'};
      expect(
        ProprietaryString.fromJson(json),
        equals(const ProprietaryString(title: 'aTitle', value: 'aString')),
      );
    });

    test('valid ProprietaryString with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aString'};
      expect(
        ProprietaryString.fromJson(json),
        equals(const ProprietaryString(title: 'aTitle', description: 'aDescription', value: 'aString')),
      );
    });

    test('valid ProprietaryString with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aString'};
      expect(
        ProprietaryString.fromJson(json),
        equals(const ProprietaryString(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aString')),
      );
    });
    test('valid ProprietaryString description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aString'};
      expect(
        ProprietaryString.fromJson(json),
        equals(const ProprietaryString(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'aString')),
      );
    });
  });
}
