import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Street(value: 'aStreet');
  group('Street to json', () {
    test('valid Street', () {
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

  group('Street from json', () {
    test('valid Street', () {
      final json = {'value': 'aStreet'};
      expect(Street.fromJson(json), equals(identityAttributeValue));
    });
  });
}
