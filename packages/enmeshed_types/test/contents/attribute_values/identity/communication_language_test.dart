import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = CommunicationLanguage(value: 'de');
  group('Communication Language to json', () {
    test('valid CommunicationLanguage', () {
      final identityJson = identityAttributeValue.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'CommunicationLanguage',
          'value': 'de',
        }),
      );
    });
  });

  group('Communication Language from json', () {
    test('valid CommunicationLanguage', () {
      final json = {'value': 'de'};
      expect(CommunicationLanguage.fromJson(json), equals(identityAttributeValue));
    });
  });
}
