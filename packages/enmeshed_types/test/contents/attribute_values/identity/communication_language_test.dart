import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const identityAttributeValue = CommunicationLanguage(value: 'de');
  group('CommunicationLanguage toJson', () {
    test('is correctly converted', () {
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
      expect(CommunicationLanguage.fromJson(json), equals(identityAttributeValue));
    });
  });
}
