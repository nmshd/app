import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ResponseWrapper toJson', () {
    test('is correctly converted', () {
      const responseWrapper = ResponseWrapper(
        requestId: 'aRequestId',
        requestSourceReference: 'aRequestSourceReference',
        requestSourceType: RequestSourceType.Message,
        response: Response(
          result: ResponseResult.Accepted,
          requestId: 'aRequestId',
          items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
        ),
      );
      final responseWrapperJson = responseWrapper.toJson();
      expect(
        responseWrapperJson,
        equals({
          '@type': 'ResponseWrapper',
          'requestId': 'aRequestId',
          'requestSourceReference': 'aRequestSourceReference',
          'requestSourceType': 'Message',
          'response':
              const Response(
                result: ResponseResult.Accepted,
                requestId: 'aRequestId',
                items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
              ).toJson(),
        }),
      );
    });
  });

  group('ResponseWrapper fromJson', () {
    test('is correctly converted', () {
      final json = {
        '@type': 'ResponseWrapper',
        'requestId': 'aRequestId',
        'requestSourceReference': 'aRequestSourceReference',
        'requestSourceType': 'Message',
        'response':
            const Response(
              result: ResponseResult.Accepted,
              requestId: 'aRequestId',
              items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
            ).toJson(),
      };
      expect(
        ResponseWrapper.fromJson(json),
        equals(
          const ResponseWrapper(
            requestId: 'aRequestId',
            requestSourceReference: 'aRequestSourceReference',
            requestSourceType: RequestSourceType.Message,
            response: Response(
              result: ResponseResult.Accepted,
              requestId: 'aRequestId',
              items: [CreateAttributeAcceptResponseItem(attributeId: 'anAttributeId')],
            ),
          ),
        ),
      );
    });
  });
}
