import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryEMailAddress toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryEMailAddress(title: 'aTitle', value: 'test@test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryEMailAddress', 'title': 'aTitle', 'value': 'test@test.com'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryEMailAddress(title: 'aTitle', description: 'aDescription', value: 'test@test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryEMailAddress', 'title': 'aTitle', 'description': 'aDescription', 'value': 'test@test.com'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryEMailAddress(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'test@test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryEMailAddress', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'test@test.com'}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
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

  group('ProprietaryEMailAddress fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 'test@test.com'};
      expect(
        ProprietaryEMailAddress.fromJson(json),
        equals(const ProprietaryEMailAddress(title: 'aTitle', value: 'test@test.com')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'test@test.com'};
      expect(
        ProprietaryEMailAddress.fromJson(json),
        equals(const ProprietaryEMailAddress(title: 'aTitle', description: 'aDescription', value: 'test@test.com')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'test@test.com'};
      expect(
        ProprietaryEMailAddress.fromJson(json),
        equals(const ProprietaryEMailAddress(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'test@test.com')),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'test@test.com'};
      expect(
        ProprietaryEMailAddress.fromJson(json),
        equals(const ProprietaryEMailAddress(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'test@test.com')),
      );
    });
  });
}
