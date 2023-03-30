import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = BirthYear(value: 1970);
  group('BirthYear toJson', () {
    test('is correctly converted', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'BirthYear',
          'value': 1970,
        }),
      );
    });
  });

  group('BirthYear fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 1970};
      expect(BirthYear.fromJson(json), equals(identityAttributeValue));
    });
  });
}
