import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Street(value: 'aStreet');
  group('Street toJson', () {
    test('is correctly converted', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'Street',
          'value': 'aStreet',
        }),
      );
    });
  });

  group('Street fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aStreet'};
      expect(Street.fromJson(json), equals(identityAttributeValue));
    });
  });
}
