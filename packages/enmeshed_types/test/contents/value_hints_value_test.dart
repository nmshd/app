import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ValueHintsValue toJson', () {
    test('is correctly converted', () {
      const valueHintsValue = ValueHintsValue(key: ValueHintsDefaultValueString('aDefaultValue'), displayName: 'aDisplayName');
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
      expect(
        ValueHintsValue.fromJson(json),
        equals(const ValueHintsValue(key: ValueHintsDefaultValueString('aDefaultValue'), displayName: 'aDisplayName')),
      );
    });
  });
}
