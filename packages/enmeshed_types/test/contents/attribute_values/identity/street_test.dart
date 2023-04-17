import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Street toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = Street(value: 'aStreet');
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
      expect(Street.fromJson(json), equals(const Street(value: 'aStreet')));
    });
  });
}
