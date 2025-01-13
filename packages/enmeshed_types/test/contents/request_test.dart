import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Request toJson', () {
    test('is correctly converted', () {
      const request = Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]);
      final requestJson = request.toJson();
      expect(
        requestJson,
        equals({
          '@type': 'Request',
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City')).toJson()],
        }),
      );
    });

    test('is correctly converted with property "id"', () {
      const request = Request(id: 'aId', items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))]);
      final requestJson = request.toJson();
      expect(
        requestJson,
        equals({
          '@type': 'Request',
          'id': 'aId',
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City')).toJson()],
        }),
      );
    });

    test('is correctly converted with property "expiresAt"', () {
      const request = Request(
        expiresAt: '2053',
        items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
      );
      final requestJson = request.toJson();
      expect(
        requestJson,
        equals({
          '@type': 'Request',
          'expiresAt': '2053',
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City')).toJson()],
        }),
      );
    });

    test('is correctly converted with property "title"', () {
      const request = Request(
        title: 'aTitle',
        items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
      );
      final requestJson = request.toJson();
      expect(
        requestJson,
        equals({
          '@type': 'Request',
          'title': 'aTitle',
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City')).toJson()],
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const request = Request(
        description: 'aDescription',
        items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
      );
      final requestJson = request.toJson();
      expect(
        requestJson,
        equals({
          '@type': 'Request',
          'description': 'aDescription',
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City')).toJson()],
        }),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const request = Request(
        metadata: {},
        items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
      );
      final requestJson = request.toJson();
      expect(
        requestJson,
        equals({
          '@type': 'Request',
          'metadata': {},
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City')).toJson()],
        }),
      );
    });

    test('is correctly converted with properties "id", "expiresAt", "title", "description" and "metadata"', () {
      const request = Request(
        id: 'aId',
        expiresAt: '2053',
        items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
        title: 'aTitle',
        description: 'aDescription',
        metadata: {},
      );
      final requestJson = request.toJson();
      expect(
        requestJson,
        equals({
          '@type': 'Request',
          'id': 'aId',
          'expiresAt': '2053',
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City')).toJson()],
          'title': 'aTitle',
          'description': 'aDescription',
          'metadata': {},
        }),
      );
    });
  });

  group('Request fromJson', () {
    test('is correctly converted', () {
      final json = {
        'items': [
          const ReadAttributeRequestItem(
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
          ).toJson(),
        ],
      };
      expect(
        Request.fromJson(json),
        equals(const Request(items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))])),
      );
    });

    test('is correctly converted with property "id"', () {
      final json = {
        'id': 'aId',
        'items': [
          const ReadAttributeRequestItem(
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
          ).toJson(),
        ],
      };
      expect(
        Request.fromJson(json),
        equals(const Request(id: 'aId', items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))])),
      );
    });

    test('is correctly converted with property "expiresAt"', () {
      final json = {
        'expiresAt': '2053',
        'items': [
          const ReadAttributeRequestItem(
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
          ).toJson(),
        ],
      };
      expect(
        Request.fromJson(json),
        equals(const Request(
          expiresAt: '2053',
          items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
        )),
      );
    });

    test('is correctly converted with property "title"', () {
      final json = {
        'title': 'aTitle',
        'items': [
          const ReadAttributeRequestItem(
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
          ).toJson(),
        ],
      };
      expect(
        Request.fromJson(json),
        equals(const Request(
          title: 'aTitle',
          items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
        )),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'description': 'aDescription',
        'items': [
          const ReadAttributeRequestItem(
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
          ).toJson(),
        ],
      };
      expect(
        Request.fromJson(json),
        equals(const Request(
          description: 'aDescription',
          items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
        )),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'items': [
          const ReadAttributeRequestItem(
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
          ).toJson(),
        ],
      };
      expect(
        Request.fromJson(json),
        equals(const Request(
          metadata: {'aKey': 'aValue'},
          items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
        )),
      );
    });

    test('is correctly converted with properties "id", "expiresAt", "title", "description" and "metadata"', () {
      final json = {
        'id': 'aId',
        'expiresAt': '2053',
        'items': [
          const ReadAttributeRequestItem(
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
          ).toJson(),
        ],
        'title': 'aTitle',
        'description': 'aDescription',
        'metadata': {'aKey': 'aValue'},
      };
      expect(
        Request.fromJson(json),
        equals(const Request(
          id: 'aId',
          expiresAt: '2053',
          items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'City'))],
          title: 'aTitle',
          description: 'aDescription',
          metadata: {'aKey': 'aValue'},
        )),
      );
    });
  });
}
