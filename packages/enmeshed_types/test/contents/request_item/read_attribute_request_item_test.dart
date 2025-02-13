import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ReadAttributeRequestItem toJson', () {
    test('is correctly converted', () {
      const readAttributeRequestItem = ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'));
      final requestItemJson = readAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({'@type': 'ReadAttributeRequestItem', 'mustBeAccepted': true, 'query': const IdentityAttributeQuery(valueType: 'City').toJson()}),
      );
    });

    test('is correctly converted with property "title"', () {
      const readAttributeRequestItem = ReadAttributeRequestItem(
        title: 'aTitle',
        mustBeAccepted: true,
        query: IdentityAttributeQuery(valueType: 'City'),
      );
      final requestItemJson = readAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ReadAttributeRequestItem',
          'title': 'aTitle',
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const readAttributeRequestItem = ReadAttributeRequestItem(
        description: 'aDescription',
        mustBeAccepted: true,
        query: IdentityAttributeQuery(valueType: 'City'),
      );
      final requestItemJson = readAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ReadAttributeRequestItem',
          'description': 'aDescription',
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        }),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const readAttributeRequestItem = ReadAttributeRequestItem(metadata: {}, mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'));
      final requestItemJson = readAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ReadAttributeRequestItem',
          'metadata': {},
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        }),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      const readAttributeRequestItem = ReadAttributeRequestItem(
        mustBeAccepted: true,
        requireManualDecision: true,
        query: IdentityAttributeQuery(valueType: 'City'),
      );
      final requestItemJson = readAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ReadAttributeRequestItem',
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        }),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata" and "requireManualDecision"', () {
      const readAttributeRequestItem = ReadAttributeRequestItem(
        title: 'aTitle',
        description: 'aDescription',
        metadata: {},
        mustBeAccepted: true,
        requireManualDecision: true,
        query: IdentityAttributeQuery(valueType: 'City'),
      );
      final requestItemJson = readAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ReadAttributeRequestItem',
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

  group('ReadAttributeRequestItem fromJson', () {
    test('is correctly converted', () {
      final json = {'mustBeAccepted': true, 'query': const IdentityAttributeQuery(valueType: 'City').toJson()};
      expect(
        ReadAttributeRequestItem.fromJson(json),
        equals(const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))),
      );
    });

    test('is correctly converted with property "title"', () {
      final json = {'title': 'aTitle', 'mustBeAccepted': true, 'query': const IdentityAttributeQuery(valueType: 'City').toJson()};
      expect(
        ReadAttributeRequestItem.fromJson(json),
        equals(const ReadAttributeRequestItem(title: 'aTitle', mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {'description': 'aDescription', 'mustBeAccepted': true, 'query': const IdentityAttributeQuery(valueType: 'City').toJson()};
      expect(
        ReadAttributeRequestItem.fromJson(json),
        equals(const ReadAttributeRequestItem(description: 'aDescription', mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
      };
      expect(
        ReadAttributeRequestItem.fromJson(json),
        equals(const ReadAttributeRequestItem(metadata: {'aKey': 'aValue'}, mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      final json = {'requireManualDecision': true, 'mustBeAccepted': true, 'query': const IdentityAttributeQuery(valueType: 'City').toJson()};
      expect(
        ReadAttributeRequestItem.fromJson(json),
        equals(const ReadAttributeRequestItem(requireManualDecision: true, mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))),
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
        ReadAttributeRequestItem.fromJson(json),
        equals(
          const ReadAttributeRequestItem(
            title: 'aTitle',
            description: 'aDescription',
            metadata: {'aKey': 'aValue'},
            mustBeAccepted: true,
            requireManualDecision: true,
            query: IdentityAttributeQuery(valueType: 'City'),
          ),
        ),
      );
    });
  });
}
