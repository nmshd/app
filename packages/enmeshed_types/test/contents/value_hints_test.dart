import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ValueHints toJson', () {
    test('is correctly converted', () {
      const valueHints = ValueHints();
      final valueHintsJson = valueHints.toJson();
      expect(
        valueHintsJson,
        equals({'editHelp': null, 'min': null, 'max': null, 'pattern': null, 'values': null, 'defaultValue': null, 'propertyHints': null}),
      );
    });

    test('is correctly converted with property "editHelp"', () {
      const valueHints = ValueHints(editHelp: 'anEditHelp');
      final valueHintsJson = valueHints.toJson();
      expect(
        valueHintsJson,
        equals({'editHelp': 'anEditHelp', 'min': null, 'max': null, 'pattern': null, 'values': null, 'defaultValue': null, 'propertyHints': null}),
      );
    });

    test('is correctly converted with property "min"', () {
      const valueHints = ValueHints(min: 0);
      final valueHintsJson = valueHints.toJson();
      expect(
        valueHintsJson,
        equals({'editHelp': null, 'min': 0, 'max': null, 'pattern': null, 'values': null, 'defaultValue': null, 'propertyHints': null}),
      );
    });

    test('is correctly converted with property "max"', () {
      const valueHints = ValueHints(max: 10);
      final valueHintsJson = valueHints.toJson();
      expect(
        valueHintsJson,
        equals({'editHelp': null, 'min': null, 'max': 10, 'pattern': null, 'values': null, 'defaultValue': null, 'propertyHints': null}),
      );
    });

    test('is correctly converted with property "pattern"', () {
      const valueHints = ValueHints(pattern: 'aPattern');
      final valueHintsJson = valueHints.toJson();
      expect(
        valueHintsJson,
        equals({'editHelp': null, 'min': null, 'max': null, 'pattern': 'aPattern', 'values': null, 'defaultValue': null, 'propertyHints': null}),
      );
    });

    test('is correctly converted with property "values"', () {
      const valueHints = ValueHints(values: [ValueHintsValue(key: 'aKey', displayName: 'aDisplayName')]);
      final valueHintsJson = valueHints.toJson();
      expect(
        valueHintsJson,
        equals({
          'editHelp': null,
          'min': null,
          'max': null,
          'pattern': null,
          'values': [const ValueHintsValue(key: 'aKey', displayName: 'aDisplayName').toJson()],
          'defaultValue': null,
          'propertyHints': null,
        }),
      );
    });

    test('is correctly converted with property "defaultValue"', () {
      const valueHints = ValueHints(defaultValue: 'aDefaultValue');
      final valueHintsJson = valueHints.toJson();
      expect(
        valueHintsJson,
        equals({'editHelp': null, 'min': null, 'max': null, 'pattern': null, 'values': null, 'defaultValue': 'aDefaultValue', 'propertyHints': null}),
      );
    });

    test('is correctly converted with property "propertyHints"', () {
      const valueHints = ValueHints(propertyHints: {'aKey': ValueHints()});
      final valueHintsJson = valueHints.toJson();
      expect(
        valueHintsJson,
        equals({
          'editHelp': null,
          'min': null,
          'max': null,
          'pattern': null,
          'values': null,
          'defaultValue': null,
          'propertyHints': {'aKey': const ValueHints().toJson()},
        }),
      );
    });

    test('is correctly converted with properties "editHelp", "min", "max", "pattern", "values", "defaultValue" and "propertyHints"', () {
      const valueHints = ValueHints(
        editHelp: 'anEditHelp',
        min: 0,
        max: 10,
        pattern: 'aPattern',
        values: [ValueHintsValue(key: 'aKey', displayName: 'aDisplayName')],
        defaultValue: 'aDefaultValue',
        propertyHints: {'aKey': ValueHints()},
      );
      final valueHintsJson = valueHints.toJson();
      expect(
        valueHintsJson,
        equals({
          'editHelp': 'anEditHelp',
          'min': 0,
          'max': 10,
          'pattern': 'aPattern',
          'values': [const ValueHintsValue(key: 'aKey', displayName: 'aDisplayName').toJson()],
          'defaultValue': 'aDefaultValue',
          'propertyHints': {'aKey': const ValueHints().toJson()},
        }),
      );
    });
  });

  group('ValueHints fromJson', () {
    test('is correctly converted', () {
      final json = {'editHelp': null, 'min': null, 'max': null, 'pattern': null, 'values': null, 'defaultValue': null, 'propertyHints': null};
      expect(ValueHints.fromJson(json), equals(const ValueHints()));
    });

    test('is correctly converted with property "editHelp"', () {
      final json = {'editHelp': 'anEditHelp', 'min': null, 'max': null, 'pattern': null, 'values': null, 'defaultValue': null, 'propertyHints': null};
      expect(ValueHints.fromJson(json), equals(const ValueHints(editHelp: 'anEditHelp')));
    });

    test('is correctly converted with property "min"', () {
      final json = {'editHelp': null, 'min': 0, 'max': null, 'pattern': null, 'values': null, 'defaultValue': null, 'propertyHints': null};
      expect(ValueHints.fromJson(json), equals(const ValueHints(min: 0)));
    });

    test('is correctly converted with property "max"', () {
      final json = {'editHelp': null, 'min': null, 'max': 10, 'pattern': null, 'values': null, 'defaultValue': null, 'propertyHints': null};
      expect(ValueHints.fromJson(json), equals(const ValueHints(max: 10)));
    });

    test('is correctly converted with property "pattern"', () {
      final json = {'editHelp': null, 'min': null, 'max': null, 'pattern': 'aPattern', 'values': null, 'defaultValue': null, 'propertyHints': null};
      expect(ValueHints.fromJson(json), equals(const ValueHints(pattern: 'aPattern')));
    });

    test('is correctly converted with property "values"', () {
      final json = {
        'editHelp': null,
        'min': null,
        'max': null,
        'pattern': null,
        'values': [const ValueHintsValue(key: 'aKey', displayName: 'aDisplayName').toJson()],
        'defaultValue': null,
        'propertyHints': null,
      };
      expect(ValueHints.fromJson(json), equals(const ValueHints(values: [ValueHintsValue(key: 'aKey', displayName: 'aDisplayName')])));
    });

    test('is correctly converted with property "defaultValue"', () {
      final json = {
        'editHelp': null,
        'min': null,
        'max': null,
        'pattern': null,
        'values': null,
        'defaultValue': 'aDefaultValue',
        'propertyHints': null,
      };
      expect(ValueHints.fromJson(json), equals(const ValueHints(defaultValue: 'aDefaultValue')));
    });

    test('is correctly converted with property "propertyHints"', () {
      final json = {
        'editHelp': null,
        'min': null,
        'max': null,
        'pattern': null,
        'values': null,
        'defaultValue': null,
        'propertyHints': {'aKey': const ValueHints().toJson()},
      };
      expect(ValueHints.fromJson(json), equals(const ValueHints(propertyHints: {'aKey': ValueHints()})));
    });

    test('is correctly converted with properties "editHelp", "min", "max", "pattern", "values", "defaultValue" and "propertyHints"', () {
      final json = {
        'editHelp': 'anEditHelp',
        'min': 0,
        'max': 10,
        'pattern': 'aPattern',
        'values': [const ValueHintsValue(key: 'aKey', displayName: 'aDisplayName').toJson()],
        'defaultValue': 'aDefaultValue',
        'propertyHints': {'aKey': const ValueHints().toJson()},
      };
      expect(
        ValueHints.fromJson(json),
        equals(const ValueHints(
          editHelp: 'anEditHelp',
          min: 0,
          max: 10,
          pattern: 'aPattern',
          values: [ValueHintsValue(key: 'aKey', displayName: 'aDisplayName')],
          defaultValue: 'aDefaultValue',
          propertyHints: {'aKey': ValueHints()},
        )),
      );
    });
  });
}
