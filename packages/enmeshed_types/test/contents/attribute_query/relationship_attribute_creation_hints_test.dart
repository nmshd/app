import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Relationship Attribute Creation Hints to json',
    () {
      test('valid RelationshipAttributeCreationHints', () {
        const relationshipAttributeCreationHints =
            RelationshipAttributeCreationHints(title: 'testCreationHint', valueType: 'ProprietaryInteger', confidentiality: 'public');
        final creationHintsJson = relationshipAttributeCreationHints.toJson();
        expect(creationHintsJson, equals({'title': 'testCreationHint', 'valueType': 'ProprietaryInteger', 'confidentiality': 'public'}));
      });

      test('valid RelationshipAttributeCreationHints with description', () {
        const relationshipAttributeCreationHints =
            RelationshipAttributeCreationHints(title: 'testCreationHint', valueType: 'ProprietaryInteger', confidentiality: 'public', description: 'testDescription');
        final creationHintsJson = relationshipAttributeCreationHints.toJson();
        expect(creationHintsJson, equals({'title': 'testCreationHint', 'valueType': 'ProprietaryInteger', 'confidentiality': 'public', 'description': 'testDescription'}));
      });

      test('valid RelationshipAttributeCreationHints with valueHints', () {
        const relationshipAttributeCreationHints =
            RelationshipAttributeCreationHints(title: 'testCreationHint', valueType: 'ProprietaryInteger', confidentiality: 'public', valueHints: ValueHints());
        final creationHintsJson = relationshipAttributeCreationHints.toJson();
        expect(creationHintsJson, equals({'title': 'testCreationHint', 'valueType': 'ProprietaryInteger', 'confidentiality': 'public', 'valueHints': const ValueHints()}));
      });

      test('valid RelationshipAttributeCreationHints with description and valueHints', () {
        const relationshipAttributeCreationHints =
            RelationshipAttributeCreationHints(title: 'testCreationHint', valueType: 'ProprietaryInteger', confidentiality: 'public', description: 'testDescription', valueHints: ValueHints());
        final creationHintsJson = relationshipAttributeCreationHints.toJson();
        expect(creationHintsJson, equals({'title': 'testCreationHint', 'valueType': 'ProprietaryInteger', 'confidentiality': 'public', 'description': 'testDescription', 'valueHints': const ValueHints()}));
      });
    },
  );

}
