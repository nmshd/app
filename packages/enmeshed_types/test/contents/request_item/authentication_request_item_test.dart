import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AuthenticationRequestItem toJson', () {
    test('is correctly converted', () {
      const authenticationRequestItem = AuthenticationRequestItem(mustBeAccepted: true);
      final requestItemJson = authenticationRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'AuthenticationRequestItem', 'mustBeAccepted': true}),
      );
    });

    test('is correctly converted with property "title"', () {
      const authenticationRequestItem = AuthenticationRequestItem(title: 'aTitle', mustBeAccepted: true);
      final requestItemJson = authenticationRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'AuthenticationRequestItem', 'title': 'aTitle', 'mustBeAccepted': true}),
      );
    });

    test('is correctly converted with property "description"', () {
      const authenticationRequestItem = AuthenticationRequestItem(description: 'aDescription', mustBeAccepted: true);
      final requestItemJson = authenticationRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'AuthenticationRequestItem', 'description': 'aDescription', 'mustBeAccepted': true}),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const authenticationRequestItem = AuthenticationRequestItem(metadata: {}, mustBeAccepted: true);
      final requestItemJson = authenticationRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'AuthenticationRequestItem', 'metadata': {}, 'mustBeAccepted': true}),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      const authenticationRequestItem = AuthenticationRequestItem(mustBeAccepted: true, requireManualDecision: true);
      final requestItemJson = authenticationRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'AuthenticationRequestItem', 'mustBeAccepted': true, 'requireManualDecision': true}),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata" and "requireManualDecision"', () {
      const authenticationRequestItem = AuthenticationRequestItem(
        title: 'aTitle',
        description: 'aDescription',
        metadata: {},
        mustBeAccepted: true,
        requireManualDecision: true,
      );
      final requestItemJson = authenticationRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'AuthenticationRequestItem',
          'title': 'aTitle',
          'description': 'aDescription',
          'metadata': {},
          'mustBeAccepted': true,
          'requireManualDecision': true,
        }),
      );
    });
  });

  group('AuthenticationRequestItem fromJson', () {
    test('is correctly converted', () {
      final json = {'mustBeAccepted': true};
      expect(
        AuthenticationRequestItem.fromJson(json),
        equals(const AuthenticationRequestItem(mustBeAccepted: true)),
      );
    });

    test('is correctly converted with property "title"', () {
      final json = {'title': 'aTitle', 'mustBeAccepted': true};
      expect(
        AuthenticationRequestItem.fromJson(json),
        equals(const AuthenticationRequestItem(title: 'aTitle', mustBeAccepted: true)),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'description': 'aDescription', 'mustBeAccepted': true};
      expect(
        AuthenticationRequestItem.fromJson(json),
        equals(const AuthenticationRequestItem(description: 'aDescription', mustBeAccepted: true)),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
      };
      expect(
        AuthenticationRequestItem.fromJson(json),
        equals(const AuthenticationRequestItem(metadata: {'aKey': 'aValue'}, mustBeAccepted: true)),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      final json = {'requireManualDecision': true, 'mustBeAccepted': true};
      expect(
        AuthenticationRequestItem.fromJson(json),
        equals(const AuthenticationRequestItem(requireManualDecision: true, mustBeAccepted: true)),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata" and "requireManualDecision"', () {
      final json = {
        'title': 'aTitle',
        'description': 'aDescription',
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'requireManualDecision': true,
      };
      expect(
        AuthenticationRequestItem.fromJson(json),
        equals(const AuthenticationRequestItem(
          title: 'aTitle',
          description: 'aDescription',
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          requireManualDecision: true,
        )),
      );
    });
  });
}
