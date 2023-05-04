import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Response toJson', () {
    test('is correctly converted with an AcceptResponseItem', () {
      const response = Response(
        result: ResponseResult.Accepted,
        requestId: 'aRequestId',
        items: [
          ReadAttributeAcceptResponseItem(
            attributeId: 'anAttributeId',
            attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ),
        ],
      );
      final responseJson = response.toJson();
      expect(
        responseJson,
        equals({
          'result': 'Accepted',
          'requestId': 'aRequestId',
          'items': [
            const ReadAttributeAcceptResponseItem(
              attributeId: 'anAttributeId',
              attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
            ).toJson(),
          ],
        }),
      );
    });

    test('is correctly converted with a RejectResponseItem', () {
      const response = Response(
        result: ResponseResult.Accepted,
        requestId: 'aRequestId',
        items: [RejectResponseItem()],
      );
      final responseJson = response.toJson();
      expect(
        responseJson,
        equals({
          'result': 'Accepted',
          'requestId': 'aRequestId',
          'items': [const RejectResponseItem().toJson()],
        }),
      );
    });

    test('is correctly converted with an ErrorResponseItem', () {
      const response = Response(
        result: ResponseResult.Accepted,
        requestId: 'aRequestId',
        items: [ErrorResponseItem(code: 'aCode', message: 'aMessage')],
      );
      final responseJson = response.toJson();
      expect(
        responseJson,
        equals({
          'result': 'Accepted',
          'requestId': 'aRequestId',
          'items': [const ErrorResponseItem(code: 'aCode', message: 'aMessage').toJson()],
        }),
      );
    });
  });

  group('Response fromJson', () {
    test('is correctly converted with an AcceptResponseItem', () {
      final json = {
        'result': 'Accepted',
        'requestId': 'aRequestId',
        'items': [
          const ReadAttributeAcceptResponseItem(
            attributeId: 'anAttributeId',
            attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ).toJson(),
        ],
      };
      expect(
        Response.fromJson(json),
        equals(const Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [
          ReadAttributeAcceptResponseItem(
            attributeId: 'anAttributeId',
            attribute: IdentityAttribute(owner: 'anOwner', value: CityAttributeValue(value: 'aCity')),
          ),
        ])),
      );
    });

    test('is correctly converted with a RejectResponseItem', () {
      final json = {
        'result': 'Accepted',
        'requestId': 'aRequestId',
        'items': [const RejectResponseItem().toJson()],
      };
      expect(
        Response.fromJson(json),
        equals(const Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [RejectResponseItem()])),
      );
    });

    test('is correctly converted with an ErrorResponseItem', () {
      final json = {
        'result': 'Accepted',
        'requestId': 'aRequestId',
        'items': [const ErrorResponseItem(code: 'aCode', message: 'aMessage').toJson()],
      };
      expect(
        Response.fromJson(json),
        equals(
          const Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: [ErrorResponseItem(code: 'aCode', message: 'aMessage')]),
        ),
      );
    });
  });
}
