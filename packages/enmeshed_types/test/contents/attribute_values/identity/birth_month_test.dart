import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthMonth(value: 01);
  group('BirthMonth toJson', () {
    test('is correctly converted', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthMonth',
          'value': 01,
        }),
      );
    });
  });

  group('BirthMonth fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 01};
      expect(BirthMonth.fromJson(json), equals(identityAttributeValue));
    });
  });
}
