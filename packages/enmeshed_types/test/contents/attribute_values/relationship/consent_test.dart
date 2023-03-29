import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Consent to json', () {
    test('valid Consent', () {
      const relationshipAttributeValue = Consent(consent: 'aConsent');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'Consent', 'consent': 'aConsent'}),
      );
    });

    test('valid Consent with valueHintsOverride', () {
      const relationshipAttributeValue = Consent(consent: 'aConsent', valueHintsOverride: ValueHints());
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'Consent', 'consent': 'aConsent', 'valueHintsOverride': const ValueHints().toJson()}),
      );
    });

    test('valid Consent with link', () {
      const relationshipAttributeValue = Consent(consent: 'aConsent', link: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'Consent', 'consent': 'aConsent', 'link': 'www.test.com'}),
      );
    });

    test('valid Consent with link and valueHintsOverride', () {
      const relationshipAttributeValue = Consent(consent: 'aConsent', valueHintsOverride: ValueHints(), link: 'www.test.com');
      final relationshipJson = relationshipAttributeValue.toJson();
      expect(
        relationshipJson,
        equals({'@type': 'Consent', 'consent': 'aConsent', 'valueHintsOverride': const ValueHints().toJson(), 'link': 'www.test.com'}),
      );
    });
  });

  group('Consent from json', () {
    test('valid Consent', () {
      final json = {
        'consent': 'aConsent',
      };
      expect(
        Consent.fromJson(json),
        equals(const Consent(consent: 'aConsent')),
      );
    });

    test('valid Consent with valueHintsOverride', () {
      final json = {'consent': 'aConsent', 'valueHintsOverride': const ValueHints().toJson()};
      expect(
        Consent.fromJson(json),
        equals(const Consent(consent: 'aConsent', valueHintsOverride: ValueHints())),
      );
    });

    test('valid Consent with link', () {
      final json = {'consent': 'aConsent', 'link': 'www.test.com'};
      expect(
        Consent.fromJson(json),
        equals(const Consent(consent: 'aConsent', link: 'www.test.com')),
      );
    });
    test('valid Consent with link and valueHintsOverride', () {
      final json = {'consent': 'aConsent', 'valueHintsOverride': const ValueHints().toJson(), 'link': 'www.test.com'};
      expect(
        Consent.fromJson(json),
        equals(const Consent(consent: 'aConsent', valueHintsOverride: ValueHints(), link: 'www.test.com')),
      );
    });
  });
}
