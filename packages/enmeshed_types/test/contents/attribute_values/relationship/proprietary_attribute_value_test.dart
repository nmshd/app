import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Proprietary Attribute Value to json', () {
    test('valid ProprietaryAttributeValue', () {
      const relationshipAttributeValue = MockProprietaryAttributeValue(title: 'aTitle');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'title': 'aTitle'}),
      );
    });

    test('valid ProprietaryAttributeValue with description', () {
      const relationshipAttributeValue = MockProprietaryAttributeValue(title: 'aTitle', description: 'aDescription');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'title': 'aTitle', 'description': 'aDescription'}),
      );
    });

    test('valid ProprietaryAttributeValue with valueHintsOverride', () {
      const relationshipAttributeValue = MockProprietaryAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints());
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson()}),
      );
    });

    test('valid ProprietaryAttributeValue with description and valueHintsOverride', () {
      const relationshipAttributeValue = MockProprietaryAttributeValue(
        title: 'aTitle',
        description: 'aDescription',
        valueHintsOverride: ValueHints(),
      );
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({
          'title': 'aTitle',
          'description': 'aDescription',
          'valueHintsOverride': const ValueHints().toJson(),
        }),
      );
    });
  });
}

class MockProprietaryAttributeValue extends ProprietaryAttributeValue {
  const MockProprietaryAttributeValue({
    required super.title,
    super.description,
    super.valueHintsOverride,
  });

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
      };
}
