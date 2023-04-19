import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ResponseItemDerivation fromJson', () {
    test('parsed valid RejectResponseItem', () {
      final responseItemJson = {'@type': 'RejectResponseItem', 'result': 'Rejected'};

      final responseItemDerivation = ResponseItemDerivation.fromJson(responseItemJson);
      expect(responseItemDerivation, isA<RejectResponseItem>());
    });

    test('parsed valid ErrorResponseItem', () {
      final responseItemJson = {'@type': 'ErrorResponseItem', 'code': 'aCode', 'message': 'aMessage', 'result': 'Error'};

      final responseItemDerivation = ResponseItemDerivation.fromJson(responseItemJson);
      expect(responseItemDerivation, isA<ErrorResponseItem>());
    });

    test('parsed valid AcceptResponseItem', () {
      final responseItemJson = {
        '@type': 'ReadAttributeAcceptResponseItem',
        'attributeId': 'anAttributeId',
        'attribute': const IdentityAttribute(owner: 'anOwner', value: City(value: 'aCity')).toJson(),
      };

      final responseItemDerivation = ResponseItemDerivation.fromJson(responseItemJson);
      expect(responseItemDerivation, isA<AcceptResponseItem>());
    });
  });

  group('ResponseItemDerivation fromJson', () {
    test('throws exception when type is unknown', () {
      final json = {'@type': 'UnknownType'};
      expect(() => ResponseItemDerivation.fromJson(json), throwsA(isA<Exception>()));
    });
  });

  group('ResponseItemDerivation toJson', () {
    test('is correctly converted', () {
      const mockResponseItemDerivation = MockResponseItemDerivation(result: ResponseItemResult.Accepted);

      expect(mockResponseItemDerivation.toJson(), equals({'result': 'Accepted'}));
    });
  });
}

class MockResponseItemDerivation extends ResponseItemDerivation {
  const MockResponseItemDerivation({required super.result});

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
    };
  }
}
