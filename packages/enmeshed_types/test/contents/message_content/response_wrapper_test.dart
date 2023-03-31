import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  const responseWrapper = ResponseWrapper(
    requestId: 'aRequestId',
    requestSourceReference: 'aRequestSourceReference',
    requestSourceType: RequestSourceType.Message,
    response: Response(result: 'aResult', requestId: 'aRequestId', items: []),
  );
  group('ResponseWrapper toJson', () {
    test('is correctly converted', () {
      final identityJson = responseWrapper.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'ResponseWrapper',
          'requestId': 'aRequestId',
          'requestSourceReference': 'aRequestSourceReference',
          'requestSourceType': 'Message',
          'response': const Response(result: 'aResult', requestId: 'aRequestId', items: []).toJson(),
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
        'response': const Response(result: 'aResult', requestId: 'aRequestId', items: []).toJson(),
      };
      expect(ResponseWrapper.fromJson(json), equals(responseWrapper));
    });
  });
}
