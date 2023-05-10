import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryPhoneNumberAttributeValue toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryPhoneNumberAttributeValue(title: 'aTitle', value: 'aPhoneNumber');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryPhoneNumber', 'title': 'aTitle', 'value': 'aPhoneNumber'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = ProprietaryPhoneNumberAttributeValue(title: 'aTitle', description: 'aDescription', value: 'aPhoneNumber');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryPhoneNumber', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aPhoneNumber'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue =
          ProprietaryPhoneNumberAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aPhoneNumber');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryPhoneNumber', 'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aPhoneNumber'}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryPhoneNumberAttributeValue(
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

  group('ProprietaryPhoneNumberAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 'aPhoneNumber'};
      expect(
        ProprietaryPhoneNumberAttributeValue.fromJson(json),
        equals(const ProprietaryPhoneNumberAttributeValue(title: 'aTitle', value: 'aPhoneNumber')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aPhoneNumber'};
      expect(
        ProprietaryPhoneNumberAttributeValue.fromJson(json),
        equals(const ProprietaryPhoneNumberAttributeValue(title: 'aTitle', description: 'aDescription', value: 'aPhoneNumber')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aPhoneNumber'};
      expect(
        ProprietaryPhoneNumberAttributeValue.fromJson(json),
        equals(const ProprietaryPhoneNumberAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aPhoneNumber')),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aPhoneNumber'};
      expect(
        ProprietaryPhoneNumberAttributeValue.fromJson(json),
        equals(const ProprietaryPhoneNumberAttributeValue(
          title: 'aTitle',
          description: 'aDescription',
          valueHintsOverride: ValueHints(),
          value: 'aPhoneNumber',
        )),
      );
    });
  });
}
