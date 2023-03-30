import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = State(value: 'aState');
  group('State toJson', () {
    test('is correctly converted', () {
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

  group('State fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aState'};
      expect(State.fromJson(json), equals(identityAttributeValue));
    });
  });
}
