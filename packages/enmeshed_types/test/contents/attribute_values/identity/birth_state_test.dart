import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthState(value: 'aBirthState');
  group('Birth State to json', () {
    test('valid BirthState', () {
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

  group('Birth State from json', () {
    test('valid BirthState', () {
      final json = {'value': 'aBirthState'};
      expect(BirthState.fromJson(json), equals(identityAttributeValue));
    });
  });
}
