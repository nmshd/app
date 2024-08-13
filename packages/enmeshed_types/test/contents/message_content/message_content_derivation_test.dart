import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('MessageContentDerivation fromJson', () {
    test('parsed valid Mail', () {
      final mailJson = {
        '@type': 'Mail',
        'to': ['aRecipient'],
        'subject': 'aSubject',
        'body': 'aBody',
      };
      final messageContent = MessageContentDerivation.fromJson(mailJson);
      expect(messageContent, isA<Mail>());
    });

    test('parsed valid ResponseWrapper', () {
      final responseWrapperJson = {
        '@type': 'ResponseWrapper',
        'requestId': 'aRequestId',
        'requestSourceReference': 'aRequestSourceReference',
        'requestSourceType': 'Message',
        'response': const Response(result: ResponseResult.Accepted, requestId: 'aRequestId', items: []).toJson(),
      };
      final messageContent = MessageContentDerivation.fromJson(responseWrapperJson);
      expect(messageContent, isA<ResponseWrapper>());
    });

    group('MessageContentDerivation fromJson with exception', () {
      test('throws exception when @type is missing', () {
        final json = {};
        expect(() => MessageContentDerivation.fromJson(json), throwsA(isA<Exception>()));
      });

      test('throws exception when type is unknown', () {
        final json = {'@type': 'UnknownType'};
        expect(() => MessageContentDerivation.fromJson(json), throwsA(isA<Exception>()));
      });
    });
  });
}
