import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('WebsiteAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = WebsiteAttributeValue(value: 'www.test.com');
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

  group('WebsiteAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'www.test.com'};
      expect(WebsiteAttributeValue.fromJson(json), equals(const WebsiteAttributeValue(value: 'www.test.com')));
    });
  });
}
