import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipAttributeCreationHints toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeCreationHints = RelationshipAttributeCreationHints(
        title: 'aCreationHint',
        valueType: 'ProprietaryInteger',
        confidentiality: 'public',
      );
      final creationHintsJson = relationshipAttributeCreationHints.toJson();
      expect(
        creationHintsJson,
        equals({
          '@type': 'RelationshipAttributeCreationHints',
          'title': 'aCreationHint',
          'valueType': 'ProprietaryInteger',
          'confidentiality': 'public',
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeCreationHints = RelationshipAttributeCreationHints(
        title: 'aCreationHint',
        valueType: 'ProprietaryInteger',
        confidentiality: 'public',
        description: 'aDescription',
      );
      final creationHintsJson = relationshipAttributeCreationHints.toJson();
      expect(
        creationHintsJson,
        equals({
          '@type': 'RelationshipAttributeCreationHints',
          'title': 'aCreationHint',
          'valueType': 'ProprietaryInteger',
          'confidentiality': 'public',
          'description': 'aDescription',
        }),
      );
    });

    test('is correctly converted with property "valueHints"', () {
      const relationshipAttributeCreationHints = RelationshipAttributeCreationHints(
        title: 'aCreationHint',
        valueType: 'ProprietaryInteger',
        confidentiality: 'public',
        valueHints: ValueHints(),
      );
      final creationHintsJson = relationshipAttributeCreationHints.toJson();
      expect(
        creationHintsJson,
        equals({
          '@type': 'RelationshipAttributeCreationHints',
          'title': 'aCreationHint',
          'valueType': 'ProprietaryInteger',
          'confidentiality': 'public',
          'valueHints': const ValueHints().toJson(),
        }),
      );
    });

    test('is correctly converted with properties "description" and "valueHints"', () {
      const relationshipAttributeCreationHints = RelationshipAttributeCreationHints(
        title: 'aCreationHint',
        valueType: 'ProprietaryInteger',
        confidentiality: 'public',
        description: 'aCreationHint',
        valueHints: ValueHints(),
      );
      final creationHintsJson = relationshipAttributeCreationHints.toJson();
      expect(
        creationHintsJson,
        equals({
          '@type': 'RelationshipAttributeCreationHints',
          'title': 'aCreationHint',
          'valueType': 'ProprietaryInteger',
          'confidentiality': 'public',
          'description': 'aCreationHint',
          'valueHints': const ValueHints().toJson(),
        }),
      );
    });
  });

  group('RelationshipAttributeCreationHints fromJson', () {
    test('is correctly converted', () {
      final json = {
        'title': 'aCreationHint',
        'valueType': 'ProprietaryInteger',
        'confidentiality': 'public',
      };
      expect(
        RelationshipAttributeCreationHints.fromJson(json),
        equals(const RelationshipAttributeCreationHints(
          title: 'aCreationHint',
          valueType: 'ProprietaryInteger',
          confidentiality: 'public',
        )),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'title': 'aCreationHint',
        'valueType': 'ProprietaryInteger',
        'confidentiality': 'public',
        'description': 'aCreationHint',
      };
      expect(
        RelationshipAttributeCreationHints.fromJson(json),
        equals(const RelationshipAttributeCreationHints(
          title: 'aCreationHint',
          valueType: 'ProprietaryInteger',
          confidentiality: 'public',
          description: 'aCreationHint',
        )),
      );
    });

    test('is correctly converted with property "valueHints"', () {
      final json = {
        'title': 'aCreationHint',
        'valueType': 'ProprietaryInteger',
        'confidentiality': 'public',
        'valueHints': null,
      };
      expect(
        RelationshipAttributeCreationHints.fromJson(json),
        equals(const RelationshipAttributeCreationHints(
          title: 'aCreationHint',
          valueType: 'ProprietaryInteger',
          confidentiality: 'public',
          valueHints: null,
        )),
      );
    });

    test('is correctly converted with properties "description" and "valueHints"', () {
      final json = {
        'title': 'aCreationHint',
        'valueType': 'ProprietaryInteger',
        'confidentiality': 'public',
        'description': 'aDescription',
        'valueHints': null,
      };
      expect(
        RelationshipAttributeCreationHints.fromJson(json),
        equals(const RelationshipAttributeCreationHints(
          title: 'aCreationHint',
          valueType: 'ProprietaryInteger',
          confidentiality: 'public',
          description: 'aDescription',
          valueHints: null,
        )),
      );
    });
  });
}
