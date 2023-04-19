import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('JobTitle toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = JobTitle(value: 'aJobTitle');
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
      expect(JobTitle.fromJson(json), equals(const JobTitle(value: 'aJobTitle')));
    });
  });
}
