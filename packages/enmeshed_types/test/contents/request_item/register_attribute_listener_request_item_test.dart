import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RegisterAttributeListenerRequestItem toJson', () {
    test('is correctly converted', () {
      const registerAttributeListenerRequestItem = RegisterAttributeListenerRequestItem(
        mustBeAccepted: true,
        query: IdentityAttributeQuery(valueType: 'City'),
      );
      final requestItemJson = registerAttributeListenerRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'RegisterAttributeListenerRequestItem',
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        }),
      );
    });

    test('is correctly converted with property "title"', () {
      const registerAttributeListenerRequestItem = RegisterAttributeListenerRequestItem(
        title: 'aTitle',
        mustBeAccepted: true,
        query: IdentityAttributeQuery(valueType: 'City'),
      );
      final requestItemJson = registerAttributeListenerRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'RegisterAttributeListenerRequestItem',
          'title': 'aTitle',
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const registerAttributeListenerRequestItem = RegisterAttributeListenerRequestItem(
        description: 'aDescription',
        mustBeAccepted: true,
        query: IdentityAttributeQuery(valueType: 'City'),
      );
      final requestItemJson = registerAttributeListenerRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'RegisterAttributeListenerRequestItem',
          'description': 'aDescription',
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        }),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const registerAttributeListenerRequestItem = RegisterAttributeListenerRequestItem(
        metadata: {},
        mustBeAccepted: true,
        query: IdentityAttributeQuery(valueType: 'City'),
      );
      final requestItemJson = registerAttributeListenerRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'RegisterAttributeListenerRequestItem',
          'metadata': {},
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        }),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      const registerAttributeListenerRequestItem = RegisterAttributeListenerRequestItem(
        mustBeAccepted: true,
        requireManualDecision: true,
        query: IdentityAttributeQuery(valueType: 'City'),
      );
      final requestItemJson = registerAttributeListenerRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'RegisterAttributeListenerRequestItem',
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        }),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata" and "requireManualDecision"', () {
      const registerAttributeListenerRequestItem = RegisterAttributeListenerRequestItem(
        title: 'aTitle',
        description: 'aDescription',
        metadata: {},
        mustBeAccepted: true,
        requireManualDecision: true,
        query: IdentityAttributeQuery(valueType: 'City'),
      );
      final requestItemJson = registerAttributeListenerRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'RegisterAttributeListenerRequestItem',
          'title': 'aTitle',
          'description': 'aDescription',
          'metadata': {},
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        }),
      );
    });
  });

  group('RegisterAttributeListenerRequestItem fromJson', () {
    test('is correctly converted', () {
      final json = {'mustBeAccepted': true, 'query': const IdentityAttributeQuery(valueType: 'City').toJson()};
      expect(
        RegisterAttributeListenerRequestItem.fromJson(json),
        equals(const RegisterAttributeListenerRequestItem(
          mustBeAccepted: true,
          query: IdentityAttributeQuery(valueType: 'City'),
        )),
      );
    });

    test('is correctly converted with property "title"', () {
      final json = {'title': 'aTitle', 'mustBeAccepted': true, 'query': const IdentityAttributeQuery(valueType: 'City').toJson()};
      expect(
        RegisterAttributeListenerRequestItem.fromJson(json),
        equals(const RegisterAttributeListenerRequestItem(
          title: 'aTitle',
          mustBeAccepted: true,
          query: IdentityAttributeQuery(valueType: 'City'),
        )),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'description': 'aDescription', 'mustBeAccepted': true, 'query': const IdentityAttributeQuery(valueType: 'City').toJson()};
      expect(
        RegisterAttributeListenerRequestItem.fromJson(json),
        equals(const RegisterAttributeListenerRequestItem(
          description: 'aDescription',
          mustBeAccepted: true,
          query: IdentityAttributeQuery(valueType: 'City'),
        )),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
      };
      expect(
        RegisterAttributeListenerRequestItem.fromJson(json),
        equals(const RegisterAttributeListenerRequestItem(
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          query: IdentityAttributeQuery(valueType: 'City'),
        )),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      final json = {'requireManualDecision': true, 'mustBeAccepted': true, 'query': const IdentityAttributeQuery(valueType: 'City').toJson()};
      expect(
        RegisterAttributeListenerRequestItem.fromJson(json),
        equals(const RegisterAttributeListenerRequestItem(
          requireManualDecision: true,
          mustBeAccepted: true,
          query: IdentityAttributeQuery(valueType: 'City'),
        )),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata" and "requireManualDecision"', () {
      final json = {
        'title': 'aTitle',
        'description': 'aDescription',
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'requireManualDecision': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
      };
      expect(
        RegisterAttributeListenerRequestItem.fromJson(json),
        equals(const RegisterAttributeListenerRequestItem(
          title: 'aTitle',
          description: 'aDescription',
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          requireManualDecision: true,
          query: IdentityAttributeQuery(valueType: 'City'),
        )),
      );
    });
  });
}
