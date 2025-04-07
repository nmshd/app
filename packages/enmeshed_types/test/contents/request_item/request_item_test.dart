import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RequestItem fromJson', () {
    test('parsed valid RequestItemGroup', () {
      final requestItemGroupJson = {'@type': 'RequestItemGroup', 'items': []};
      final requestItemGroup = RequestItem.fromJson(requestItemGroupJson);
      expect(requestItemGroup, isA<RequestItemGroup>());
    });

    test('parsed valid RequestItemDerivation', () {
      final requestItemJson = {
        '@type': 'ReadAttributeRequestItem',
        'mustBeAccepted': true,
        'requireManualDecision': true,
        'query': const IdentityAttributeQuery(valueType: 'City').toJson(),
      };
      final requestItemDerivation = RequestItem.fromJson(requestItemJson);
      expect(requestItemDerivation, isA<RequestItemDerivation>());
    });
  });

  group('RequestItem fromJson with exception', () {
    test('throws exception when @type is missing', () {
      final json = {'mustBeAccepted': true};
      expect(() => RequestItem.fromJson(json), throwsA(isA<Exception>()));
    });

    test('throws exception when type is unknown', () {
      final json = {'@type': 'UnknownType', 'mustBeAccepted': true};
      expect(() => RequestItem.fromJson(json), throwsA(isA<Exception>()));
    });
  });

  group('RequestItem toJson', () {
    test('is correctly converted', () {
      const mockMockRequestItem = MockRequestItem(mustBeAccepted: true);

      expect(mockMockRequestItem.toJson(), equals({'mustBeAccepted': true}));
    });

    test('is correctly converted with property "title"', () {
      const mockMockRequestItem = MockRequestItem(title: 'aTitle', mustBeAccepted: true);

      expect(mockMockRequestItem.toJson(), equals({'title': 'aTitle', 'mustBeAccepted': true}));
    });

    test('is correctly converted with property "description"', () {
      const mockMockRequestItem = MockRequestItem(description: 'aDescription', mustBeAccepted: true);

      expect(mockMockRequestItem.toJson(), equals({'description': 'aDescription', 'mustBeAccepted': true}));
    });

    test('is correctly converted with property "metadata"', () {
      const mockMockRequestItem = MockRequestItem(metadata: {}, mustBeAccepted: true);

      expect(mockMockRequestItem.toJson(), equals({'metadata': {}, 'mustBeAccepted': true}));
    });

    test('is correctly converted with properties "title", "description" and "metadata"', () {
      const mockMockRequestItem = MockRequestItem(title: 'aTitle', description: 'aDescription', metadata: {}, mustBeAccepted: true);

      expect(mockMockRequestItem.toJson(), equals({'title': 'aTitle', 'description': 'aDescription', 'metadata': {}, 'mustBeAccepted': true}));
    });
  });
}

class MockRequestItem extends RequestItem {
  final bool mustBeAccepted;

  const MockRequestItem({super.title, super.description, super.metadata, required this.mustBeAccepted}) : super(atType: 'MockRequestItem');

  @override
  Map<String, dynamic> toJson() {
    return {
      'mustBeAccepted': mustBeAccepted,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (metadata != null) 'metadata': metadata,
    };
  }
}
