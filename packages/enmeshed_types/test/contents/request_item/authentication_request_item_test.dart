import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AuthenticationRequestItem toJson', () {
    test('is correctly converted', () {
      const authenticationRequestItem = AuthenticationRequestItem(title: 'aTitle', mustBeAccepted: true);
      final requestItemJson = authenticationRequestItem.toJson();
      expect(requestItemJson, equals({'@type': 'AuthenticationRequestItem', 'title': 'aTitle', 'mustBeAccepted': true}));
    });

    test('is correctly converted with property "description"', () {
      const authenticationRequestItem = AuthenticationRequestItem(description: 'aDescription', title: 'aTitle', mustBeAccepted: true);
      final requestItemJson = authenticationRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'AuthenticationRequestItem', 'description': 'aDescription', 'title': 'aTitle', 'mustBeAccepted': true}),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const authenticationRequestItem = AuthenticationRequestItem(metadata: {}, title: 'aTitle', mustBeAccepted: true);
      final requestItemJson = authenticationRequestItem.toJson();
      expect(requestItemJson, equals({'@type': 'AuthenticationRequestItem', 'metadata': {}, 'title': 'aTitle', 'mustBeAccepted': true}));
    });

    test('is correctly converted with property "requireManualDecision"', () {
      const authenticationRequestItem = AuthenticationRequestItem(requireManualDecision: true, title: 'aTitle', mustBeAccepted: true);
      final requestItemJson = authenticationRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'AuthenticationRequestItem', 'requireManualDecision': true, 'title': 'aTitle', 'mustBeAccepted': true}),
      );
    });

    test('is correctly converted with properties "description", "metadata" and "requireManualDecision"', () {
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
      final json = {'title': 'aTitle', 'mustBeAccepted': true};
      expect(AuthenticationRequestItem.fromJson(json), equals(const AuthenticationRequestItem(title: 'aTitle', mustBeAccepted: true)));
    });

    test('is correctly converted with property "description"', () {
      final json = {'description': 'aDescription', 'title': 'aTitle', 'mustBeAccepted': true};
      expect(
        AuthenticationRequestItem.fromJson(json),
        equals(const AuthenticationRequestItem(description: 'aDescription', title: 'aTitle', mustBeAccepted: true)),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'title': 'aTitle',
        'mustBeAccepted': true,
      };
      expect(
        AuthenticationRequestItem.fromJson(json),
        equals(const AuthenticationRequestItem(metadata: {'aKey': 'aValue'}, title: 'aTitle', mustBeAccepted: true)),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      final json = {'requireManualDecision': true, 'title': 'aTitle', 'mustBeAccepted': true};
      expect(
        AuthenticationRequestItem.fromJson(json),
        equals(const AuthenticationRequestItem(requireManualDecision: true, title: 'aTitle', mustBeAccepted: true)),
      );
    });

    test('is correctly converted with properties "description", "metadata" and "requireManualDecision"', () {
      final json = {
        'title': 'aTitle',
        'description': 'aDescription',
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'requireManualDecision': true,
      };
      expect(
        AuthenticationRequestItem.fromJson(json),
        equals(
          const AuthenticationRequestItem(
            title: 'aTitle',
            description: 'aDescription',
            metadata: {'aKey': 'aValue'},
            mustBeAccepted: true,
            requireManualDecision: true,
          ),
        ),
      );
    });
  });
}
