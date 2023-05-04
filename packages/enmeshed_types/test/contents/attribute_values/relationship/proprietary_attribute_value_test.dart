import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProprietaryAttributeValue toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = MockProprietaryAttributeValue(title: 'aTitle');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'title': 'aTitle'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const relationshipAttributeValue = MockProprietaryAttributeValue(title: 'aTitle', description: 'aDescription');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'title': 'aTitle', 'description': 'aDescription'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = MockProprietaryAttributeValue(title: 'aTitle', valueHintsOverride: ValueHints());
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'title': 'aTitle', 'valueHintsOverride': const ValueHints().toJson()}),
      );
    });

    test('is correctly converted with properties "description" and "valueHintsOverride"', () {
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

class MockProprietaryAttributeValue extends ProprietaryAttributeValueAttributeValue {
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
