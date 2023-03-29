import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = JobTitle(value: 'aJobTitle');
  group('Job Title to json', () {
    test('valid JobTitle', () {
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

  group('Job Title from json', () {
    test('valid JobTitle', () {
      final json = {'value': 'aJobTitle'};
      expect(JobTitle.fromJson(json), equals(identityAttributeValue));
    });
  });
}
