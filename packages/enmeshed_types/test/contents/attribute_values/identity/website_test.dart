import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Website(value: 'www.test.com');
  group('Website to json', () {
    test('valid Website', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'Website',
          'value': 'www.test.com',
        }),
      );
    });
  });

  group('Website from json', () {
    test('valid Website', () {
      final json = {'value': 'www.test.com'};
      expect(Website.fromJson(json), equals(identityAttributeValue));
    });
  });
}
