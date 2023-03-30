import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = Website(value: 'www.test.com');
  group('Website toJson', () {
    test('is correctly converted', () {
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
      expect(Website.fromJson(json), equals(identityAttributeValue));
    });
  });
}
