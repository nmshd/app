import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Relationship Attribute Creation Hints to json',
    () {
      test('valid RelationshipAttributeCreationHints', () {
        const relationshipAttributeCreationHints = RelationshipAttributeCreationHints(
          title: 'aCreationHint',
          valueType: 'ProprietaryInteger',
          confidentiality: 'public',
        );
        final creationHintsJson = relationshipAttributeCreationHints.toJson();
        expect(
          creationHintsJson,
          equals({
            'title': 'aCreationHint',
            'valueType': 'ProprietaryInteger',
            'confidentiality': 'public',
          }),
        );
      });

      test('valid RelationshipAttributeCreationHints with description', () {
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
            'title': 'aCreationHint',
            'valueType': 'ProprietaryInteger',
            'confidentiality': 'public',
            'description': 'aDescription',
          }),
        );
      });

      test('valid RelationshipAttributeCreationHints with valueHints', () {
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
            'title': 'aCreationHint',
            'valueType': 'ProprietaryInteger',
            'confidentiality': 'public',
            'valueHints': const ValueHints(),
          }),
        );
      });

      test('valid RelationshipAttributeCreationHints with description and valueHints', () {
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
            'title': 'aCreationHint',
            'valueType': 'ProprietaryInteger',
            'confidentiality': 'public',
            'description': 'aCreationHint',
            'valueHints': const ValueHints(),
          }),
        );
      });
    },
  );

  group('Relationship Attribute Creation Hints from json', () {
    test('valid RelationshipAttributeCreationHints', () {
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

    test('valid RelationshipAttributeCreationHints with description', () {
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

    test('valid RelationshipAttributeCreationHints with valueHints', () {
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

    test('valid RelationshipAttributeCreationHints with description and valueHints', () {
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
