import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RequestItemDerivation fromJson', () {
    test('parsed valid ReadAttributeRequestItem', () {
      final requestItemJson = {
        '@type': 'ReadAttributeRequestItem',
        'mustBeAccepted': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
      };

      final requestItemGroup = RequestItemDerivation.fromJson(requestItemJson);
      expect(requestItemGroup, isA<ReadAttributeRequestItem>());
    });

    test('parsed valid CreateAttributeRequestItem', () {
      final requestItemJson = {
        '@type': 'CreateAttributeRequestItem',
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };

      final requestItemGroup = RequestItemDerivation.fromJson(requestItemJson);
      expect(requestItemGroup, isA<CreateAttributeRequestItem>());
    });

    test('parsed valid ShareAttributeRequestItem', () {
      final requestItemJson = {
        '@type': 'ShareAttributeRequestItem',
        'mustBeAccepted': true,
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'sourceAttributeId': 'aSourceAttributeId',
      };

      final requestItemGroup = RequestItemDerivation.fromJson(requestItemJson);
      expect(requestItemGroup, isA<ShareAttributeRequestItem>());
    });

    test('parsed valid ProposeAttributeRequestItem', () {
      final requestItemJson = {
        '@type': 'ProposeAttributeRequestItem',
        'mustBeAccepted': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
        'attribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
      };

      final requestItemGroup = RequestItemDerivation.fromJson(requestItemJson);
      expect(requestItemGroup, isA<ProposeAttributeRequestItem>());
    });

    test('parsed valid ConsentRequestItem', () {
      final requestItemJson = {
        '@type': 'ConsentRequestItem',
        'mustBeAccepted': true,
        'consent': 'aConsent',
      };

      final requestItemGroup = RequestItemDerivation.fromJson(requestItemJson);
      expect(requestItemGroup, isA<ConsentRequestItem>());
    });

    test('parsed valid AuthenticationRequestItem', () {
      final requestItemJson = {
        '@type': 'AuthenticationRequestItem',
        'mustBeAccepted': true,
      };

      final requestItemGroup = RequestItemDerivation.fromJson(requestItemJson);
      expect(requestItemGroup, isA<AuthenticationRequestItem>());
    });

    test('parsed valid RegisterAttributeListenerRequestItem', () {
      final requestItemJson = {
        '@type': 'RegisterAttributeListenerRequestItem',
        'mustBeAccepted': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
      };

      final requestItemGroup = RequestItemDerivation.fromJson(requestItemJson);
      expect(requestItemGroup, isA<RegisterAttributeListenerRequestItem>());
    });

    test('parsed valid SucceedAttributeRequestItem', () {
      final requestItemJson = {
        '@type': 'SucceedAttributeRequestItem',
        'mustBeAccepted': true,
        'succeededId': 'aSucceededId',
        'succeededAttribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')).toJson(),
        'newAttribute': const IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'newCity')).toJson(),
      };

      final requestItemGroup = RequestItemDerivation.fromJson(requestItemJson);
      expect(requestItemGroup, isA<SucceedAttributeRequestItem>());
    });
  });

  group('RequestItemDerivation fromJson', () {
    test('throws exception when type is unknown', () {
      final json = {
        '@type': 'UnknownType',
        'mustBeAccepted': true,
      };
      expect(() => RequestItemDerivation.fromJson(json), throwsA(isA<Exception>()));
    });
  });

  group('RequestItemDerivation toJson', () {
    test('is correctly converted', () {
      const mockRequestItemDerivation = MockRequestItemDerivation(mustBeAccepted: true);

      expect(mockRequestItemDerivation.toJson(), equals({'mustBeAccepted': true}));
    });

    test('is correctly converted with property "title"', () {
      const mockRequestItemDerivation = MockRequestItemDerivation(title: 'aTitle', mustBeAccepted: true);

      expect(mockRequestItemDerivation.toJson(), equals({'title': 'aTitle', 'mustBeAccepted': true}));
    });

    test('is correctly converted with property "description"', () {
      const mockRequestItemDerivation = MockRequestItemDerivation(description: 'aDescription', mustBeAccepted: true);

      expect(mockRequestItemDerivation.toJson(), equals({'description': 'aDescription', 'mustBeAccepted': true}));
    });

    test('is correctly converted with property "metadata"', () {
      const mockRequestItemDerivation = MockRequestItemDerivation(metadata: {}, mustBeAccepted: true);

      expect(mockRequestItemDerivation.toJson(), equals({'metadata': {}, 'mustBeAccepted': true}));
    });

    test('is correctly converted with property "requireManualDecision"', () {
      const mockRequestItemDerivation = MockRequestItemDerivation(requireManualDecision: true, mustBeAccepted: true);

      expect(mockRequestItemDerivation.toJson(), equals({'requireManualDecision': true, 'mustBeAccepted': true}));
    });

    test('is correctly converted with properties "title", "description", "metadata" and "requireManualDecision"', () {
      const mockRequestItemDerivation = MockRequestItemDerivation(
        title: 'aTitle',
        description: 'aDescription',
        metadata: {},
        requireManualDecision: true,
        mustBeAccepted: true,
      );

      expect(
        mockRequestItemDerivation.toJson(),
        equals({
          'title': 'aTitle',
          'description': 'aDescription',
          'metadata': {},
          'requireManualDecision': true,
          'mustBeAccepted': true,
        }),
      );
    });
  });
}

class MockRequestItemDerivation extends RequestItemDerivation {
  const MockRequestItemDerivation({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
    };
  }
}
