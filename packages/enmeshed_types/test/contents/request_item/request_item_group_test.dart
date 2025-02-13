import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RequestItemGroup toJson', () {
    test('is correctly converted', () {
      const requestItemGroup = RequestItemGroup(
        items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
      );
      final requestItemGroupJson = requestItemGroup.toJson();
      expect(
        requestItemGroupJson,
        equals({
          '@type': 'RequestItemGroup',
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType')).toJson()],
        }),
      );
    });

    test('is correctly converted with property "title"', () {
      const requestItemGroup = RequestItemGroup(
        title: 'aTitle',
        items: [ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType'))],
      );
      final requestItemGroupJson = requestItemGroup.toJson();
      expect(
        requestItemGroupJson,
        equals({
          '@type': 'RequestItemGroup',
          'title': 'aTitle',
          'items': [const ReadAttributeRequestItem(mustBeAccepted: true, query: IdentityAttributeQuery(valueType: 'aValueType')).toJson()],
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const requestItemGroup = RequestItemGroup(description: 'aDescription', items: []);
      final requestItemGroupJson = requestItemGroup.toJson();
      expect(requestItemGroupJson, equals({'@type': 'RequestItemGroup', 'description': 'aDescription', 'items': []}));
    });

    test('is correctly converted with property "metadata"', () {
      const requestItemGroup = RequestItemGroup(metadata: {}, items: []);
      final requestItemGroupJson = requestItemGroup.toJson();
      expect(requestItemGroupJson, equals({'@type': 'RequestItemGroup', 'metadata': {}, 'items': []}));
    });

    test('is correctly converted with properties "title", "description" and "metadata"', () {
      const requestItemGroup = RequestItemGroup(title: 'aTitle', description: 'aDescription', metadata: {}, items: []);
      final requestItemGroupJson = requestItemGroup.toJson();
      expect(
        requestItemGroupJson,
        equals({'@type': 'RequestItemGroup', 'title': 'aTitle', 'description': 'aDescription', 'metadata': {}, 'items': []}),
      );
    });
  });

  group('RequestItemGroup fromJson', () {
    test('is correctly converted', () {
      final json = {'items': []};
      expect(RequestItemGroup.fromJson(json), equals(const RequestItemGroup(items: [])));
    });

    test('is correctly converted with property "title', () {
      final json = {'title': 'aTitle', 'items': []};
      expect(RequestItemGroup.fromJson(json), equals(const RequestItemGroup(title: 'aTitle', items: [])));
    });

    test('is correctly converted with property "description', () {
      final json = {'description': 'aDescription', 'items': []};
      expect(RequestItemGroup.fromJson(json), equals(const RequestItemGroup(description: 'aDescription', items: [])));
    });

    test('is correctly converted with property "metadata', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'items': [],
      };
      expect(RequestItemGroup.fromJson(json), equals(const RequestItemGroup(metadata: {'aKey': 'aValue'}, items: [])));
    });

    test('is correctly converted with properties "title", "description" and "metadata"', () {
      final json = {
        'title': 'aTitle',
        'description': 'aDescription',
        'metadata': {'aKey': 'aValue'},
        'items': [],
      };
      expect(
        RequestItemGroup.fromJson(json),
        equals(const RequestItemGroup(title: 'aTitle', description: 'aDescription', metadata: {'aKey': 'aValue'}, items: [])),
      );
    });
  });
}
