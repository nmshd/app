import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Website toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = Website(value: 'www.test.com');
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

  group('Website fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'www.test.com'};
      expect(Website.fromJson(json), equals(const Website(value: 'www.test.com')));
    });
  });
}
