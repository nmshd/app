import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ProposeAttributeRequestItem toJson', () {
    test('is correctly converted', () {
      const proposeAttributeRequestItem = ProposeAttributeRequestItem(
        mustBeAccepted: true,
        query: IdentityAttributeQuery(valueType: 'City'),
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = proposeAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ProposeAttributeRequestItem',
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "title"', () {
      const proposeAttributeRequestItem = ProposeAttributeRequestItem(
        title: 'aTitle',
        mustBeAccepted: true,
        query: IdentityAttributeQuery(valueType: 'City'),
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = proposeAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ProposeAttributeRequestItem',
          'title': 'aTitle',
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const proposeAttributeRequestItem = ProposeAttributeRequestItem(
        description: 'aDescription',
        mustBeAccepted: true,
        query: IdentityAttributeQuery(valueType: 'City'),
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = proposeAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ProposeAttributeRequestItem',
          'description': 'aDescription',
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const proposeAttributeRequestItem = ProposeAttributeRequestItem(
        metadata: {},
        mustBeAccepted: true,
        query: IdentityAttributeQuery(valueType: 'City'),
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = proposeAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ProposeAttributeRequestItem',
          'metadata': {},
          'mustBeAccepted': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      const proposeAttributeRequestItem = ProposeAttributeRequestItem(
        mustBeAccepted: true,
        requireManualDecision: true,
        query: IdentityAttributeQuery(valueType: 'City'),
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = proposeAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ProposeAttributeRequestItem',
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata" and "requireManualDecision"', () {
      const proposeAttributeRequestItem = ProposeAttributeRequestItem(
        title: 'aTitle',
        description: 'aDescription',
        metadata: {},
        mustBeAccepted: true,
        requireManualDecision: true,
        query: IdentityAttributeQuery(valueType: 'City'),
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = proposeAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ProposeAttributeRequestItem',
          'title': 'aTitle',
          'description': 'aDescription',
          'metadata': {},
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });
  });

  group('ProposeAttributeRequestItem fromJson', () {
    test('is correctly converted', () {
      final json = {
        'mustBeAccepted': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        ProposeAttributeRequestItem.fromJson(json),
        equals(
          const ProposeAttributeRequestItem(
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
            attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ),
        ),
      );
    });

    test('is correctly converted with property "title"', () {
      final json = {
        'title': 'aTitle',
        'mustBeAccepted': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        ProposeAttributeRequestItem.fromJson(json),
        equals(
          const ProposeAttributeRequestItem(
            title: 'aTitle',
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
            attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ),
        ),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'description': 'aDescription',
        'mustBeAccepted': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        ProposeAttributeRequestItem.fromJson(json),
        equals(
          const ProposeAttributeRequestItem(
            description: 'aDescription',
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
            attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ),
        ),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        ProposeAttributeRequestItem.fromJson(json),
        equals(
          const ProposeAttributeRequestItem(
            metadata: {'aKey': 'aValue'},
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
            attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ),
        ),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      final json = {
        'requireManualDecision': true,
        'mustBeAccepted': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        ProposeAttributeRequestItem.fromJson(json),
        equals(
          const ProposeAttributeRequestItem(
            requireManualDecision: true,
            mustBeAccepted: true,
            query: IdentityAttributeQuery(valueType: 'City'),
            attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ),
        ),
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
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        ProposeAttributeRequestItem.fromJson(json),
        equals(
          const ProposeAttributeRequestItem(
            title: 'aTitle',
            description: 'aDescription',
            metadata: {'aKey': 'aValue'},
            mustBeAccepted: true,
            requireManualDecision: true,
            query: IdentityAttributeQuery(valueType: 'City'),
            attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ),
        ),
      );
    });
  });
}
