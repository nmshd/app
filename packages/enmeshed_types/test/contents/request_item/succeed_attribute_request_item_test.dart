import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('SucceedAttributeRequestItem toJson', () {
    test('is correctly converted', () {
      const succeedAttributeRequestItem = SucceedAttributeRequestItem(
        mustBeAccepted: true,
        succeededId: 'aSucceededId',
        succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
        newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
      );
      final requestItemJson = succeedAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'SucceedAttributeRequestItem',
          'mustBeAccepted': true,
          'succeededId': 'aSucceededId',
          'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
          'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "title"', () {
      const succeedAttributeRequestItem = SucceedAttributeRequestItem(
        title: 'aTitle',
        mustBeAccepted: true,
        succeededId: 'aSucceededId',
        succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
        newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
      );
      final requestItemJson = succeedAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'SucceedAttributeRequestItem',
          'title': 'aTitle',
          'mustBeAccepted': true,
          'succeededId': 'aSucceededId',
          'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
          'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const succeedAttributeRequestItem = SucceedAttributeRequestItem(
        description: 'aDescription',
        mustBeAccepted: true,
        succeededId: 'aSucceededId',
        succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
        newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
      );
      final requestItemJson = succeedAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'SucceedAttributeRequestItem',
          'description': 'aDescription',
          'mustBeAccepted': true,
          'succeededId': 'aSucceededId',
          'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
          'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "metadata"', () {
      const succeedAttributeRequestItem = SucceedAttributeRequestItem(
        metadata: {},
        mustBeAccepted: true,
        succeededId: 'aSucceededId',
        succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
        newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
      );
      final requestItemJson = succeedAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'SucceedAttributeRequestItem',
          'metadata': {},
          'mustBeAccepted': true,
          'succeededId': 'aSucceededId',
          'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
          'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      const succeedAttributeRequestItem = SucceedAttributeRequestItem(
        mustBeAccepted: true,
        requireManualDecision: true,
        succeededId: 'aSucceededId',
        succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
        newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
      );
      final requestItemJson = succeedAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'SucceedAttributeRequestItem',
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'succeededId': 'aSucceededId',
          'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
          'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
        }),
      );
    });

    test('is correctly converted with properties "title", "description", "metadata" and "requireManualDecision"', () {
      const succeedAttributeRequestItem = SucceedAttributeRequestItem(
        title: 'aTitle',
        description: 'aDescription',
        metadata: {},
        mustBeAccepted: true,
        requireManualDecision: true,
        succeededId: 'aSucceededId',
        succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
        newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
      );
      final requestItemJson = succeedAttributeRequestItem.toJson();
      expect(
        requestItemJson,
        equals({
          '@type': 'SucceedAttributeRequestItem',
          'title': 'aTitle',
          'description': 'aDescription',
          'metadata': {},
          'mustBeAccepted': true,
          'requireManualDecision': true,
          'succeededId': 'aSucceededId',
          'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
          'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
        }),
      );
    });
  });

  group('SucceedAttributeRequestItem fromJson', () {
    test('is correctly converted', () {
      final json = {
        'mustBeAccepted': true,
        'succeededId': 'aSucceededId',
        'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
        'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
      };
      expect(
        SucceedAttributeRequestItem.fromJson(json),
        equals(const SucceedAttributeRequestItem(
          mustBeAccepted: true,
          succeededId: 'aSucceededId',
          succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
          newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
        )),
      );
    });

    test('is correctly converted with property "title"', () {
      final json = {
        'title': 'aTitle',
        'mustBeAccepted': true,
        'succeededId': 'aSucceededId',
        'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
        'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
      };
      expect(
        SucceedAttributeRequestItem.fromJson(json),
        equals(const SucceedAttributeRequestItem(
          title: 'aTitle',
          mustBeAccepted: true,
          succeededId: 'aSucceededId',
          succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
          newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
        )),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'description': 'aDescription',
        'mustBeAccepted': true,
        'succeededId': 'aSucceededId',
        'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
        'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
      };
      expect(
        SucceedAttributeRequestItem.fromJson(json),
        equals(const SucceedAttributeRequestItem(
          description: 'aDescription',
          mustBeAccepted: true,
          succeededId: 'aSucceededId',
          succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
          newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
        )),
      );
    });

    test('is correctly converted with property "metadata"', () {
      final json = {
        'metadata': {'aKey': 'aValue'},
        'mustBeAccepted': true,
        'succeededId': 'aSucceededId',
        'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
        'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
      };
      expect(
        SucceedAttributeRequestItem.fromJson(json),
        equals(const SucceedAttributeRequestItem(
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          succeededId: 'aSucceededId',
          succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
          newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
        )),
      );
    });

    test('is correctly converted with property "requireManualDecision"', () {
      final json = {
        'requireManualDecision': true,
        'mustBeAccepted': true,
        'succeededId': 'aSucceededId',
        'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
        'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
      };
      expect(
        SucceedAttributeRequestItem.fromJson(json),
        equals(const SucceedAttributeRequestItem(
          requireManualDecision: true,
          mustBeAccepted: true,
          succeededId: 'aSucceededId',
          succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
          newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
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
        'succeededId': 'aSucceededId',
        'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
        'newAttribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')).toJson(),
      };
      expect(
        SucceedAttributeRequestItem.fromJson(json),
        equals(const SucceedAttributeRequestItem(
          title: 'aTitle',
          description: 'aDescription',
          metadata: {'aKey': 'aValue'},
          mustBeAccepted: true,
          requireManualDecision: true,
          succeededId: 'aSucceededId',
          succeededAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')),
          newAttribute: IdentityAttribute(owner: 'anOwner', value: City(value: 'newCity')),
        )),
      );
    });
  });
}
