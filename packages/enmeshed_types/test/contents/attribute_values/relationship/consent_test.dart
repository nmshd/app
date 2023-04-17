import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Consent toJson', () {
    test('is correctly converted', () {
      const relationshipAttributeValue = Consent(consent: 'aConsent');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'Consent', 'consent': 'aConsent'}),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      const relationshipAttributeValue = Consent(consent: 'aConsent', valueHintsOverride: ValueHints());
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'Consent', 'consent': 'aConsent', 'valueHintsOverride': const ValueHints().toJson()}),
      );
    });

    test('is correctly converted with property "link"', () {
      const relationshipAttributeValue = Consent(consent: 'aConsent', link: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'Consent', 'consent': 'aConsent', 'link': 'www.test.com'}),
      );
    });

    test('is correctly converted with properties "link" and "valueHintsOverride"', () {
      const relationshipAttributeValue = Consent(consent: 'aConsent', valueHintsOverride: ValueHints(), link: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'Consent', 'consent': 'aConsent', 'valueHintsOverride': const ValueHints().toJson(), 'link': 'www.test.com'}),
      );
    });
  });

  group('Consent fromJson', () {
    test('is correctly converted', () {
      final json = {
        'consent': 'aConsent',
      };
      expect(
        Consent.fromJson(json),
        equals(const Consent(consent: 'aConsent')),
      );
    });

    test('is correctly converted with property "valueHintsOverride"', () {
      final json = {'consent': 'aConsent', 'valueHintsOverride': const ValueHints().toJson()};
      expect(
        Consent.fromJson(json),
        equals(const Consent(consent: 'aConsent', valueHintsOverride: ValueHints())),
      );
    });

    test('is correctly converted with property "link"', () {
      final json = {'consent': 'aConsent', 'link': 'www.test.com'};
      expect(
        Consent.fromJson(json),
        equals(const Consent(consent: 'aConsent', link: 'www.test.com')),
      );
    });
    test('is correctly converted with properties "link" and "valueHintsOverride"', () {
      final json = {'consent': 'aConsent', 'valueHintsOverride': const ValueHints().toJson(), 'link': 'www.test.com'};
      expect(
        Consent.fromJson(json),
        equals(const Consent(consent: 'aConsent', valueHintsOverride: ValueHints(), link: 'www.test.com')),
      );
    });
  });
}
