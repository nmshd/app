import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('CommunicationLanguage toJson', () {
    test('is correctly converted', () {
      const identityAttributeValue = CommunicationLanguageAttributeValue(value: 'de');
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

  group('CommunicationLanguage fromJson', () {
    test('is correctly converted', () {
      final json = {'value': 'de'};
      expect(CommunicationLanguageAttributeValue.fromJson(json), equals(const CommunicationLanguageAttributeValue(value: 'de')));
    });
  });
}
