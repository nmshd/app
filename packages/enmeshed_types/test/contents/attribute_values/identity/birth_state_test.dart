import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthState(value: 'aBirthState');
  group('BirthState toJson', () {
    test('is correctly converted', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthState',
          'value': 'aBirthState',
        }),
      );
    });
  });

  group('BirthState fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aBirthState'};
      expect(BirthState.fromJson(json), equals(identityAttributeValue));
    });
  });
}
