import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = State(value: 'aState');
  group('State to json', () {
    test('valid State', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'State',
          'value': 'aState',
        }),
      );
    });
  });

  group('State from json', () {
    test('valid State', () {
      final json = {'value': 'aState'};
      expect(State.fromJson(json), equals(identityAttributeValue));
    });
  });
}
