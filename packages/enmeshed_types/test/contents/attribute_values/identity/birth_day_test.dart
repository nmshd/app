import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthDay(value: 01);
  group('BirthDay toJson', () {
    test('is correctly converted', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthDay',
          'value': 01,
        }),
      );
    });
  });

  group('BirthDay fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 01};
      expect(BirthDay.fromJson(json), equals(identityAttributeValue));
    });
  });
}
