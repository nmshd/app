import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary URL to json', () {
    test('valid ProprietaryURL', () {
      const relationshipAttributeValue = ProprietaryURL(title: 'aTitle', value: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryURL', 'title': 'aTitle', 'value': 'www.test.com'}),
      );
    });

    test('valid ProprietaryURL with description', () {
      const relationshipAttributeValue = ProprietaryURL(title: 'aTitle', description: 'aDescription', value: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryURL', 'title': 'aTitle', 'description': 'aDescription', 'value': 'www.test.com'}),
      );
    });

    test('valid ProprietaryURL with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryURL(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryURL', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'www.test.com'}),
      );
    });

    test('valid ProprietaryURL with description and valueHintsOverride', () {
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

  group('Proprietary URL from json', () {
    test('valid ProprietaryURL', () {
      final json = {'title': 'aTitle', 'value': 'www.test.com'};
      expect(
        ProprietaryURL.fromJson(json),
        equals(const ProprietaryURL(title: 'aTitle', value: 'www.test.com')),
      );
    });

    test('valid ProprietaryURL with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'www.test.com'};
      expect(
        ProprietaryURL.fromJson(json),
        equals(const ProprietaryURL(title: 'aTitle', description: 'aDescription', value: 'www.test.com')),
      );
    });

    test('valid ProprietaryURL with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'www.test.com'};
      expect(
        ProprietaryURL.fromJson(json),
        equals(const ProprietaryURL(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'www.test.com')),
      );
    });
    test('valid ProprietaryURL description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'www.test.com'};
      expect(
        ProprietaryURL.fromJson(json),
        equals(const ProprietaryURL(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'www.test.com')),
      );
    });
  });
}
