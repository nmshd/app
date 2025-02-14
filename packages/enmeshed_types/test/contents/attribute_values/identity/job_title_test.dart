import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('JobTitleAttributeValue toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = JobTitleAttributeValue(value: 'aJobTitle');
      final identityJson = identityAttributeValue.toJson();
      expect(identityJson, equals({'@type': 'JobTitle', 'value': 'aJobTitle'}));
    });
  });

  group('JobTitleAttributeValue fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'aJobTitle'};
      expect(JobTitleAttributeValue.fromJson(json), equals(const JobTitleAttributeValue(value: 'aJobTitle')));
    });
  });
}
