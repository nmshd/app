import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ConsentRequestItem toJson', () {
    test('is correctly converted', () {
      const consentRequestItem = ConsentRequestItem(mustBeAccepted: true, consent: 'aConsent');
      final requestItemJson = consentRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'ConsentRequestItem', 'mustBeAccepted': true, 'consent': 'aConsent'}),
      );
    });

    test('is correctly converted with property "title"', () {
      const consentRequestItem = ConsentRequestItem(title: 'aTitle', mustBeAccepted: true, consent: 'aConsent');
      final requestItemJson = consentRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'ConsentRequestItem', 'title': 'aTitle', 'mustBeAccepted': true, 'consent': 'aConsent'}),
      );
    });

    test('is correctly converted with property "description"', () {
      const consentRequestItem = ConsentRequestItem(description: 'aDescription', mustBeAccepted: true, consent: 'aConsent');
      final requestItemJson = consentRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'ConsentRequestItem', 'description': 'aDescription', 'mustBeAccepted': true, 'consent': 'aConsent'}),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const consentRequestItem = ConsentRequestItem(metadata: {}, mustBeAccepted: true, consent: 'aConsent');
      final requestItemJson = consentRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'ConsentRequestItem', 'metadata': {}, 'mustBeAccepted': true, 'consent': 'aConsent'}),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      const consentRequestItem = ConsentRequestItem(mustBeAccepted: true, requireManualDecision: true, consent: 'aConsent');
      final requestItemJson = consentRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'ConsentRequestItem', 'mustBeAccepted': true, 'requireManualDecision': true, 'consent': 'aConsent'}),
      );
    });

    test('is correctly converted with property "link"', () {
      const consentRequestItem = ConsentRequestItem(mustBeAccepted: true, consent: 'aConsent', link: 'www.test.com');
      final requestItemJson = consentRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'ConsentRequestItem', 'mustBeAccepted': true, 'consent': 'aConsent', 'link': 'www.test.com'}),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata", "requireManualDecision" and "link"', () {
      const consentRequestItem = ConsentRequestItem(
        title: 'aTitle',
        description: 'aDescription',
        metadata: {},
        mustBeAccepted: true,
        requireManualDecision: true,
        consent: 'aConsent',
        link: 'www.test.com',
      );
      final requestItemJson = consentRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ConsentRequestItem',
          'title': 'aTitle',
          'description': 'aDescription',
          'metadata': {},
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'consent': 'aConsent',
          'link': 'www.test.com',
        }),
      );
    });
  });

  group('ConsentRequestItem fromJson', () {
    test('is correctly converted', () {
      final json = {'mustBeAccepted': true, 'consent': 'aConsent'};
      expect(
        ConsentRequestItem.fromJson(json),
        equals(const ConsentRequestItem(mustBeAccepted: true, consent: 'aConsent')),
      );
    });

    test('is correctly converted with property "title"', () {
      final json = {'title': 'aTitle', 'mustBeAccepted': true, 'consent': 'aConsent'};
      expect(
        ConsentRequestItem.fromJson(json),
        equals(const ConsentRequestItem(title: 'aTitle', mustBeAccepted: true, consent: 'aConsent')),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'description': 'aDescription', 'mustBeAccepted': true, 'consent': 'aConsent'};
      expect(
        ConsentRequestItem.fromJson(json),
        equals(const ConsentRequestItem(description: 'aDescription', mustBeAccepted: true, consent: 'aConsent')),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'consent': 'aConsent',
      };
      expect(
        ConsentRequestItem.fromJson(json),
        equals(const ConsentRequestItem(metadata: {'aKey': 'aValue'}, mustBeAccepted: true, consent: 'aConsent')),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      final json = {'mustBeAccepted': true, 'requireManualDecision': true, 'consent': 'aConsent'};
      expect(
        ConsentRequestItem.fromJson(json),
        equals(const ConsentRequestItem(requireManualDecision: true, mustBeAccepted: true, consent: 'aConsent')),
      );
    });

    test('is correctly converted with property "link"', () {
      final json = {'mustBeAccepted': true, 'consent': 'aConsent', 'link': 'www.test.com'};
      expect(
        ConsentRequestItem.fromJson(json),
        equals(const ConsentRequestItem(mustBeAccepted: true, consent: 'aConsent', link: 'www.test.com')),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata", "requireManualDecision" and "link"', () {
      final json = {
        'title': 'aTitle',
        'description': 'aDescription',
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'requireManualDecision': true,
        'consent': 'aConsent',
        'link': 'www.test.com',
      };
      expect(
        ConsentRequestItem.fromJson(json),
        equals(const ConsentRequestItem(
          title: 'aTitle',
          description: 'aDescription',
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          requireManualDecision: true,
          consent: 'aConsent',
          link: 'www.test.com',
        )),
      );
    });
  });
}
