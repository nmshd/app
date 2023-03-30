import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Sex(value: 'male');
  group('Sex toJson', () {
    test('is correctly converted', () {
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

  group('Sex fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'male'};
      expect(Sex.fromJson(json), equals(identityAttributeValue));
    });
  });
}
