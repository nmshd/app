import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ValueHintsValue toJson', () {
    test('is correctly converted', () {
      const valueHintsValue = ValueHintsValue(key: 'aKey', displayName: 'aDisplayName');
      final valueHintsValueJson = valueHintsValue.toJson();
      expect(
        valueHintsValueJson,
        equals({'key': 'aKey', 'displayName': 'aDisplayName'}),
      );
    });
  });

  group('ValueHintsValue fromJson', () {
    test('is correctly converted', () {
      final json = {'key': 'aKey', 'displayName': 'aDisplayName'};
      expect(ValueHintsValue.fromJson(json), equals(const ValueHintsValue(key: 'aKey', displayName: 'aDisplayName')));
    });
  });
}
