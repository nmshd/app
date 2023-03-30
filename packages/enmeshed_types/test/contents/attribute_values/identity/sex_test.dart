import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Sex(value: 'male');
  group('Sex to json', () {
    test('valid Sex', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'Sex',
          'value': 'male',
        }),
      );
    });
  });

  group('Sex from json', () {
    test('valid Sex', () {
      final json = {'value': 'male'};
      expect(Sex.fromJson(json), equals(identityAttributeValue));
    });
  });
}
