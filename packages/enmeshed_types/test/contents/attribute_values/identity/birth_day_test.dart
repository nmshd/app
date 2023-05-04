import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthDay toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthDayAttributeValue(value: 01);
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
      expect(BirthDayAttributeValue.fromJson(json), equals(const BirthDayAttributeValue(value: 01)));
    });
  });
}
