import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryFileReferenceAttributeValue toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = ProprietaryFileReferenceAttributeValue(title: 'aTitle', value: 'aFileReference');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryFileReference', 'title': 'aTitle', 'value': 'aFileReference'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue =
          ProprietaryFileReferenceAttributeValue(title: 'aTitle', description: 'aDescription', value: 'aFileReference');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryFileReference', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aFileReference'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue =
          ProprietaryFileReferenceAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aFileReference');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryFileReference',
          'title': 'aTitle',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 'aFileReference',
        }),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      const relationshipAttributeValue = ProprietaryFileReferenceAttributeValue(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
        value: 'aFileReference',
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          '@type': 'ProprietaryFileReference',
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
          'value': 'aFileReference',
        }),
      );
    });
  });

  group('ProprietaryFileReferenceAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'title': 'aTitle', 'value': 'aFileReference'};
      expect(
        ProprietaryFileReferenceAttributeValue.fromJson(json),
        equals(const ProprietaryFileReferenceAttributeValue(title: 'aTitle', value: 'aFileReference')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aFileReference'};
      expect(
        ProprietaryFileReferenceAttributeValue.fromJson(json),
        equals(const ProprietaryFileReferenceAttributeValue(title: 'aTitle', description: 'aDescription', value: 'aFileReference')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aFileReference'};
      expect(
        ProprietaryFileReferenceAttributeValue.fromJson(json),
        equals(const ProprietaryFileReferenceAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aFileReference')),
      );
    });
    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aFileReference'};
      expect(
        ProprietaryFileReferenceAttributeValue.fromJson(json),
        equals(const ProprietaryFileReferenceAttributeValue(
          title: 'aTitle',
          description: 'aDescription',
          valueHintsOverride: ValueHints(),
          value: 'aFileReference',
        )),
      );
    });
  });
}
