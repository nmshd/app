import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('BirthMonthAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = BirthMonthAttributeValue(value: 01);
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'BirthMonth', 'value': 01}));
    });
  });

  group('BirthMonthAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 01};
      expect(BirthMonthAttributeValue.fromJson(json), equals(const BirthMonthAttributeValue(value: 01)));
    });
  });
}
