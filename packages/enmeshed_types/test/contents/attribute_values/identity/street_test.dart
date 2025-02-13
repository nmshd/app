import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('StreetAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = StreetAttributeValue(value: 'aStreet');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'Street', 'value': 'aStreet'}));
    });
  });

  group('StreetAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aStreet'};
      expect(StreetAttributeValue.fromJson(json), equals(const StreetAttributeValue(value: 'aStreet')));
    });
  });
}
