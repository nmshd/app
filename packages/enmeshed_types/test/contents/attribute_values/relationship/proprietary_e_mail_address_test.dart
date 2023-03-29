import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary E Mail Address to json', () {
    test('valid ProprietaryEMailAddress', () {
      const relationshipAttributeValue = ProprietaryEMailAddress(title: 'aTitle', value: 'test@test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryEMailAddress', 'title': 'aTitle', 'value': 'test@test.com'}),
      );
    });

    test('valid ProprietaryEMailAddress with description', () {
      const relationshipAttributeValue = ProprietaryEMailAddress(title: 'aTitle', description: 'aDescription', value: 'test@test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryEMailAddress', 'title': 'aTitle', 'description': 'aDescription', 'value': 'test@test.com'}),
      );
    });

    test('valid ProprietaryEMailAddress with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryEMailAddress(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'test@test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryEMailAddress', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'test@test.com'}),
      );
    });

    test('valid ProprietaryEMailAddress with description and valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryEMailAddress(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: 'test@test.com',
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryEMailAddress',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 'test@test.com',
        }),
      );
    });
  });

  group('Proprietary E Mail Address from json', () {
    test('valid ProprietaryEMailAddress', () {
      final json = {'title': 'aTitle', 'value': 'test@test.com'};
      expect(
        ProprietaryEMailAddress.fromJson(json),
        equals(const ProprietaryEMailAddress(title: 'aTitle', value: 'test@test.com')),
      );
    });

    test('valid ProprietaryEMailAddress with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'test@test.com'};
      expect(
        ProprietaryEMailAddress.fromJson(json),
        equals(const ProprietaryEMailAddress(title: 'aTitle', description: 'aDescription', value: 'test@test.com')),
      );
    });

    test('valid ProprietaryEMailAddress with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'test@test.com'};
      expect(
        ProprietaryEMailAddress.fromJson(json),
        equals(const ProprietaryEMailAddress(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'test@test.com')),
      );
    });
    test('valid ProprietaryEMailAddress description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'test@test.com'};
      expect(
        ProprietaryEMailAddress.fromJson(json),
        equals(const ProprietaryEMailAddress(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'test@test.com')),
      );
    });
  });
}
