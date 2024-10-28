import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ShareAttributeRequestItem toJson', () {
    test('is correctly converted', () {
      const shareAttributeRequestItem = ShareAttributeRequestItem(
        mustBeAccepted: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        sourceAttributeId: 'aSourceAttributeId',
        thirdPartyAddress: 'aThirdPartyAddress',
      );
      final requestItemJson = shareAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ShareAttributeRequestItem',
          'mustBeAccepted': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'sourceAttributeId': 'aSourceAttributeId',
          'thirdPartyAddress': 'aThirdPartyAddress',
        }),
      );
    });

    test('is correctly converted with property "title"', () {
      const shareAttributeRequestItem = ShareAttributeRequestItem(
        title: 'aTitle',
        mustBeAccepted: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        sourceAttributeId: 'aSourceAttributeId',
      );
      final requestItemJson = shareAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ShareAttributeRequestItem',
          'title': 'aTitle',
          'mustBeAccepted': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'sourceAttributeId': 'aSourceAttributeId',
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const shareAttributeRequestItem = ShareAttributeRequestItem(
        description: 'aDescription',
        mustBeAccepted: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        sourceAttributeId: 'aSourceAttributeId',
      );
      final requestItemJson = shareAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ShareAttributeRequestItem',
          'description': 'aDescription',
          'mustBeAccepted': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'sourceAttributeId': 'aSourceAttributeId',
        }),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const shareAttributeRequestItem = ShareAttributeRequestItem(
        metadata: {},
        mustBeAccepted: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        sourceAttributeId: 'aSourceAttributeId',
      );
      final requestItemJson = shareAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ShareAttributeRequestItem',
          'metadata': {},
          'mustBeAccepted': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'sourceAttributeId': 'aSourceAttributeId',
        }),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      const shareAttributeRequestItem = ShareAttributeRequestItem(
        mustBeAccepted: true,
        requireManualDecision: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        sourceAttributeId: 'aSourceAttributeId',
      );
      final requestItemJson = shareAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ShareAttributeRequestItem',
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'sourceAttributeId': 'aSourceAttributeId',
        }),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata" and "requireManualDecision"', () {
      const shareAttributeRequestItem = ShareAttributeRequestItem(
        title: 'aTitle',
        description: 'aDescription',
        metadata: {},
        mustBeAccepted: true,
        requireManualDecision: true,
        attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
        sourceAttributeId: 'aSourceAttributeId',
      );
      final requestItemJson = shareAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'ShareAttributeRequestItem',
          'title': 'aTitle',
          'description': 'aDescription',
          'metadata': {},
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
          'sourceAttributeId': 'aSourceAttributeId',
        }),
      );
    });
  });

  group('ShareAttributeRequestItem fromJson', () {
    test('is correctly converted', () {
      final json = {
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'sourceAttributeId': 'aSourceAttributeId',
        'thirdPartyAddress': 'aThirdPartyAddress',
      };
      expect(
        ShareAttributeRequestItem.fromJson(json),
        equals(const ShareAttributeRequestItem(
          mustBeAccepted: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          sourceAttributeId: 'aSourceAttributeId',
          thirdPartyAddress: 'aThirdPartyAddress',
        )),
      );
    });

    test('is correctly converted with property "title"', () {
      final json = {
        'title': 'aTitle',
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'sourceAttributeId': 'aSourceAttributeId',
      };
      expect(
        ShareAttributeRequestItem.fromJson(json),
        equals(const ShareAttributeRequestItem(
          title: 'aTitle',
          mustBeAccepted: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          sourceAttributeId: 'aSourceAttributeId',
        )),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'description': 'aDescription',
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'sourceAttributeId': 'aSourceAttributeId',
      };
      expect(
        ShareAttributeRequestItem.fromJson(json),
        equals(const ShareAttributeRequestItem(
          description: 'aDescription',
          mustBeAccepted: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          sourceAttributeId: 'aSourceAttributeId',
        )),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'sourceAttributeId': 'aSourceAttributeId',
      };
      expect(
        ShareAttributeRequestItem.fromJson(json),
        equals(const ShareAttributeRequestItem(
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          sourceAttributeId: 'aSourceAttributeId',
        )),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      final json = {
        'requireManualDecision': true,
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'sourceAttributeId': 'aSourceAttributeId',
      };
      expect(
        ShareAttributeRequestItem.fromJson(json),
        equals(const ShareAttributeRequestItem(
          requireManualDecision: true,
          mustBeAccepted: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          sourceAttributeId: 'aSourceAttributeId',
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
        'sourceAttributeId': 'aSourceAttributeId',
      };
      expect(
        ShareAttributeRequestItem.fromJson(json),
        equals(const ShareAttributeRequestItem(
          title: 'aTitle',
          description: 'aDescription',
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          requireManualDecision: true,
          attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          sourceAttributeId: 'aSourceAttributeId',
        )),
      );
    });
  });
}
