import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary File Reference to json', () {
    test('valid ProprietaryFileReference', () {
      const relationshipAttributeValue = ProprietaryFileReference(title: 'aTitle', value: 'aFileReference');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryFileReference', 'title': 'aTitle', 'value': 'aFileReference'}),
      );
    });

    test('valid ProprietaryFileReference with description', () {
      const relationshipAttributeValue = ProprietaryFileReference(title: 'aTitle', description: 'aDescription', value: 'aFileReference');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'ProprietaryFileReference', 'title': 'aTitle', 'description': 'aDescription', 'value': 'aFileReference'}),
      );
    });

    test('valid ProprietaryFileReference with valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryFileReference(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aFileReference');
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

    test('valid ProprietaryFileReference with description and valueHintsOverride', () {
      const relationshipAttributeValue = ProprietaryFileReference(
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

  group('Proprietary File Reference from json', () {
    test('valid ProprietaryFileReference', () {
      final json = {'title': 'aTitle', 'value': 'aFileReference'};
      expect(
        ProprietaryFileReference.fromJson(json),
        equals(const ProprietaryFileReference(title: 'aTitle', value: 'aFileReference')),
      );
    });

    test('valid ProprietaryFileReference with description', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'value': 'aFileReference'};
      expect(
        ProprietaryFileReference.fromJson(json),
        equals(const ProprietaryFileReference(title: 'aTitle', description: 'aDescription', value: 'aFileReference')),
      );
    });

    test('valid ProprietaryFileReference with valueHintsOverride', () {
      final json = {'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aFileReference'};
      expect(
        ProprietaryFileReference.fromJson(json),
        equals(const ProprietaryFileReference(title: 'aTitle', valueHintsOverride: ValueHints(), value: 'aFileReference')),
      );
    });
    test('valid ProprietaryFileReference description and valueHintsOverride', () {
      final json = {'title': 'aTitle', 'description': 'aDescription', 'valueHintsOverride': const ValueHints().toJson(), 'value': 'aFileReference'};
      expect(
        ProprietaryFileReference.fromJson(json),
        equals(const ProprietaryFileReference(
          title: 'aTitle',
          description: 'aDescription',
          valueHintsOverride: ValueHints(),
          value: 'aFileReference',
        )),
      );
    });
  });
}
