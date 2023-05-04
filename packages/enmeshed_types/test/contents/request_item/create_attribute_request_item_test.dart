import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('CreateAttributeRequestItem toJson', () {
    test('is correctly converted', () {
      const createAttributeRequestItem = CreateAttributeRequestItem(
        mustBeAccepted: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = createAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'CreateAttributeRequestItem',
          'mustBeAccepted': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "title"', () {
      const createAttributeRequestItem = CreateAttributeRequestItem(
        title: 'aTitle',
        mustBeAccepted: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = createAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'CreateAttributeRequestItem',
          'title': 'aTitle',
          'mustBeAccepted': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const createAttributeRequestItem = CreateAttributeRequestItem(
        description: 'aDescription',
        mustBeAccepted: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = createAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'CreateAttributeRequestItem',
          'description': 'aDescription',
          'mustBeAccepted': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const createAttributeRequestItem = CreateAttributeRequestItem(
        metadata: {},
        mustBeAccepted: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = createAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'CreateAttributeRequestItem',
          'metadata': {},
          'mustBeAccepted': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      const createAttributeRequestItem = CreateAttributeRequestItem(
        mustBeAccepted: true,
        requireManualDecision: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = createAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'CreateAttributeRequestItem',
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata" and "requireManualDecision"', () {
      const createAttributeRequestItem = CreateAttributeRequestItem(
        title: 'aTitle',
        description: 'aDescription',
        metadata: {},
        mustBeAccepted: true,
        requireManualDecision: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
      );
      final requestItemJson = createAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'CreateAttributeRequestItem',
          'title': 'aTitle',
          'description': 'aDescription',
          'metadata': {},
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        }),
      );
    });
  });

  group('CreateAttributeRequestItem fromJson', () {
    test('is correctly converted', () {
      final json = {'mustBeAccepted': true, 'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson()};
      expect(
        CreateAttributeRequestItem.fromJson(json),
        equals(const CreateAttributeRequestItem(
          mustBeAccepted: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        )),
      );
    });

    test('is correctly converted with property "title"', () {
      final json = {
        'title': 'aTitle',
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        CreateAttributeRequestItem.fromJson(json),
        equals(const CreateAttributeRequestItem(
          title: 'aTitle',
          mustBeAccepted: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        )),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'description': 'aDescription',
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        CreateAttributeRequestItem.fromJson(json),
        equals(const CreateAttributeRequestItem(
          description: 'aDescription',
          mustBeAccepted: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        )),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        CreateAttributeRequestItem.fromJson(json),
        equals(const CreateAttributeRequestItem(
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        )),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      final json = {
        'requireManualDecision': true,
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        CreateAttributeRequestItem.fromJson(json),
        equals(const CreateAttributeRequestItem(
          requireManualDecision: true,
          mustBeAccepted: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
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
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };
      expect(
        CreateAttributeRequestItem.fromJson(json),
        equals(const CreateAttributeRequestItem(
          title: 'aTitle',
          description: 'aDescription',
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          requireManualDecision: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        )),
      );
    });
  });
}
