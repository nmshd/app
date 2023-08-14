import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ValueHintsValue toJson', () {
    test('is correctly converted', () {
      const valueHintsValue = ValueHintsValue(key: ValueHintsDefaultValueString('aKey'), displayName: 'aDisplayName');
      final valueHintsValueJson = valueHintsValue.toJson();
      expect(
        valueHintsValueJson,
        equals({'@type': 'ValueHintsValue', 'key': 'aKey', 'displayName': 'aDisplayName'}),
      );
    });
  });

  group('ValueHintsValue fromJson', () {
    test('is correctly converted', () {
      final json = {'key': 'aKey', 'displayName': 'aDisplayName'};
      final valueHints = ValueHintsValue.fromJson(json);

      expect(
        valueHints,
        equals(const ValueHintsValue(key: ValueHintsDefaultValueString('aKey'), displayName: 'aDisplayName')),
      );
    });
  });
}
