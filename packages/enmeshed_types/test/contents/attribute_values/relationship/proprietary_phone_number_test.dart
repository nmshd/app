import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary Phone Number to json', () {
    test('valid ProprietaryPhoneNumber', () {
      const relationshipAttributeValue = ProprietaryPhoneNumber(title: 'aTitle', value: 'aPhoneNumber');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryPhoneNumber', 'title': 'aTitle', 'value': 'aPhoneNumber'}),
      );
    });

    test('valid ProprietaryPhoneNumber with description', () {
      const relationshipAttributeValue = ProprietaryPhoneNumber(title: 'aTitle', description: 'aDescription', value: 'aPhoneNumber');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryPhoneNumber', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aPhoneNumber'}),
      );
    });

    test('valid ProprietaryPhoneNumber with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryPhoneNumber(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aPhoneNumber');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryPhoneNumber', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aPhoneNumber'}),
      );
    });

    test('valid ProprietaryPhoneNumber with description and valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryPhoneNumber(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: 'aPhoneNumber',
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryPhoneNumber',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 'aPhoneNumber',
        }),
      );
    });
  });

  group('Proprietary Phone Number from json', () {
    test('valid ProprietaryPhoneNumber', () {
      final json = {'title': 'aTitle', 'value': 'aPhoneNumber'};
      expect(
        ProprietaryPhoneNumber.fromJson(json),
        equals(const ProprietaryPhoneNumber(title: 'aTitle', value: 'aPhoneNumber')),
      );
    });

    test('valid ProprietaryPhoneNumber with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aPhoneNumber'};
      expect(
        ProprietaryPhoneNumber.fromJson(json),
        equals(const ProprietaryPhoneNumber(title: 'aTitle', description: 'aDescription', value: 'aPhoneNumber')),
      );
    });

    test('valid ProprietaryPhoneNumber with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aPhoneNumber'};
      expect(
        ProprietaryPhoneNumber.fromJson(json),
        equals(const ProprietaryPhoneNumber(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aPhoneNumber')),
      );
    });
    test('valid ProprietaryPhoneNumber description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aPhoneNumber'};
      expect(
        ProprietaryPhoneNumber.fromJson(json),
        equals(const ProprietaryPhoneNumber(title: 'aTitle', description: 'aDescription', valueHintsOverride: ValueHints(), value: 'aPhoneNumber')),
      );
    });
  });
}
