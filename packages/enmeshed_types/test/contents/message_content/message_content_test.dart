import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('MessageContent fromJson', () {
    test('parsed valid Mail', () {
      final mailJson = {
        '@type': 'Mail',
        'to': ['aRecipient'],
        'subject': 'aSubject',
        'body': 'aBody',
      };
      final messageContent = MessageContent.fromJson(mailJson);
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
      final messageContent = MessageContent.fromJson(responseWrapperJson);
      expect(messageContent, isA<ResponseWrapper>());
    });

    group('MessageContent fromJson with exception', () {
      test('throws exception when @type is missing', () {
        final json = {};
        expect(() => MessageContent.fromJson(json), throwsA(isA<Exception>()));
      });

      test('throws exception when type is unknown', () {
        final json = {'@type': 'UnknownType'};
        expect(() => MessageContent.fromJson(json), throwsA(isA<Exception>()));
      });
    });
  });
}
