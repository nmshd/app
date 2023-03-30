import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = JobTitle(value: 'aJobTitle');
  group('JobTitle toJson', () {
    test('is correctly converted', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'JobTitle',
          'value': 'aJobTitle',
        }),
      );
    });
  });

  group('JobTitle fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aJobTitle'};
      expect(JobTitle.fromJson(json), equals(identityAttributeValue));
    });
  });
}
