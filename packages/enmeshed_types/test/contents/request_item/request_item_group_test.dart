import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RequestItemGroup toJson', () {
    test('is correctly converted', () {
      const requestItemGroup = RequestItemGroup(
        mustBeAccepted: true,
        items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
      );
      final requestItemGroupJson = requestItemGroup.toJson();
      expect(
        requestItemGroupJson,
        equals({
          '@type': 'RequestItemGroup',
          'mustBeAccepted': true,
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType')).toJson()],
        }),
      );
    });

    test('is correctly converted with property "title"', () {
      const requestItemGroup = RequestItemGroup(
        title: 'aTitle',
        mustBeAccepted: true,
        items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
      );
      final requestItemGroupJson = requestItemGroup.toJson();
      expect(
        requestItemGroupJson,
        equals({
          '@type': 'RequestItemGroup',
          'title': 'aTitle',
          'mustBeAccepted': true,
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType')).toJson()],
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const requestItemGroup = RequestItemGroup(description: 'aDescription', mustBeAccepted: true, items: []);
      final requestItemGroupJson = requestItemGroup.toJson();
      expect(
        requestItemGroupJson,
        equals({
          '@type': 'RequestItemGroup',
          'description': 'aDescription',
          'mustBeAccepted': true,
          'items': [],
        }),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const requestItemGroup = RequestItemGroup(metadata: {}, mustBeAccepted: true, items: []);
      final requestItemGroupJson = requestItemGroup.toJson();
      expect(
        requestItemGroupJson,
        equals({
          '@type': 'RequestItemGroup',
          'metadata': {},
          'mustBeAccepted': true,
          'items': [],
        }),
      );
    });

    test('is correctly converted with properties "title", "description" and "metadata"', () {
      const requestItemGroup = RequestItemGroup(title: 'aTitle', description: 'aDescription', metadata: {}, mustBeAccepted: true, items: []);
      final requestItemGroupJson = requestItemGroup.toJson();
      expect(
        requestItemGroupJson,
        equals({
          '@type': 'RequestItemGroup',
          'title': 'aTitle',
          'description': 'aDescription',
          'metadata': {},
          'mustBeAccepted': true,
          'items': [],
        }),
      );
    });
  });

  group('RequestItemGroup fromJson', () {
    test('is correctly converted', () {
      final json = {
        'mustBeAccepted': true,
        'items': [],
      };
      expect(RequestItemGroup.fromJson(json), equals(const RequestItemGroup(mustBeAccepted: true, items: [])));
    });

    test('is correctly converted with property "title', () {
      final json = {
        'title': 'aTitle',
        'mustBeAccepted': true,
        'items': [],
      };
      expect(RequestItemGroup.fromJson(json), equals(const RequestItemGroup(title: 'aTitle', mustBeAccepted: true, items: [])));
    });

    test('is correctly converted with property "description', () {
      final json = {
        'description': 'aDescription',
        'mustBeAccepted': true,
        'items': [],
      };
      expect(RequestItemGroup.fromJson(json), equals(const RequestItemGroup(description: 'aDescription', mustBeAccepted: true, items: [])));
    });

    test('is correctly converted with property "metadata', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'items': [],
      };
      expect(RequestItemGroup.fromJson(json), equals(const RequestItemGroup(metadata: {'aKey': 'aValue'}, mustBeAccepted: true, items: [])));
    });

    test('is correctly converted with properties "title", "description" and "metadata"', () {
      final json = {
        'title': 'aTitle',
        'description': 'aDescription',
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'items': [],
      };
      expect(
        RequestItemGroup.fromJson(json),
        equals(const RequestItemGroup(
          title: 'aTitle',
          description: 'aDescription',
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          items: [],
        )),
      );
    });
  });
}
