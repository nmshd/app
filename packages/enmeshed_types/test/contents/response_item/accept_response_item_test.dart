import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AcceptResponseItem fromJson', () {
    test('parsed valid CreateAttributeAcceptResponseItem', () {
      final responseItemJson = {'@type': 'CreateAttributeAcceptResponseItem', 'attributeId': 'anAttributeId'};

      final acceptResponseItem = AcceptResponseItem.fromJson(responseItemJson);
      expect(acceptResponseItem, isA<CreateAttributeAcceptResponseItem>());
    });

    test('parsed valid ShareAttributeAcceptResponseItem', () {
      final responseItemJson = {'@type': 'ShareAttributeAcceptResponseItem', 'attributeId': 'anAttributeId'};

      final acceptResponseItem = AcceptResponseItem.fromJson(responseItemJson);
      expect(acceptResponseItem, isA<ShareAttributeAcceptResponseItem>());
    });

    test('parsed valid ProposeAttributeAcceptResponseItem', () {
      final responseItemJson = {
        '@type': 'ProposeAttributeAcceptResponseItem',
        'attributeId': 'anAttributeId',
        'attribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
      };

      final acceptResponseItem = AcceptResponseItem.fromJson(responseItemJson);
      expect(acceptResponseItem, isA<ProposeAttributeAcceptResponseItem>());
    });

    test('parsed valid ReadAttributeAcceptResponseItem', () {
      final responseItemJson = {
        '@type': 'ReadAttributeAcceptResponseItem',
        'attributeId': 'anAttributeId',
        'attribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
      };

      final acceptResponseItem = AcceptResponseItem.fromJson(responseItemJson);
      expect(acceptResponseItem, isA<ReadAttributeAcceptResponseItem>());
    });

    test('parsed valid RegisterAttributeListenerAcceptResponseItem', () {
      final responseItemJson = {'@type': 'RegisterAttributeListenerAcceptResponseItem', 'listenerId': 'aListenerId'};

      final acceptResponseItem = AcceptResponseItem.fromJson(responseItemJson);
      expect(acceptResponseItem, isA<RegisterAttributeListenerAcceptResponseItem>());
    });

    test('parsed valid SucceedAttributeAcceptResponseItem', () {
      final responseItemJson = {'@type': 'SucceedAttributeAcceptResponseItem', 'attributeId': 'anAttributeId'};

      final acceptResponseItem = AcceptResponseItem.fromJson(responseItemJson);
      expect(acceptResponseItem, isA<SucceedAttributeAcceptResponseItem>());
    });
  });

  group('AcceptResponseItem fromJson', () {
    test('throws exception when type is unknown', () {
      final json = {'@type': 'UnknownType'};
      expect(() => AcceptResponseItem.fromJson(json), throwsA(isA<Exception>()));
    });
  });

  group('AcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const mockAcceptResponseItem = MockAcceptResponseItem();

      expect(mockAcceptResponseItem.toJson(), equals({'@type': 'AcceptResponseItem', 'result': 'Accepted'}));
    });
  });
}

class MockAcceptResponseItem extends AcceptResponseItem {
  const MockAcceptResponseItem();

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
    };
  }
}
