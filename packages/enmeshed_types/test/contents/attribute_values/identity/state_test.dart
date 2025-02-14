import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('StateAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = StateAttributeValue(value: 'aState');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'State', 'value': 'aState'}));
    });
  });

  group('StateAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aState'};
      expect(StateAttributeValue.fromJson(json), equals(const StateAttributeValue(value: 'aState')));
    });
  });
}
