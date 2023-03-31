import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('MessageContent fromJson', () {
    test('parsed valid Mail', () {
      final mailJson = {
        '@type': 'Mail',
        'to': ['test@test.com'],
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
        'requestSourceType': RequestSourceType.Message.name,
        'response': const Response(result: 'aResult', requestId: 'aRequestId', items: []).toJson(),
      };
      final messageContent = MessageContent.fromJson(responseWrapperJson);
      expect(messageContent, isA<ResponseWrapper>());
    });

    test('parsed valid ArbitraryMessageContent when given an unknown @type', () {
      final arbitraryMessageContentJson = {
        '@type': 'ArbitraryMessageContent',
        'internalJson': 'aInternalJson',
      };
      final messageContent = MessageContent.fromJson(arbitraryMessageContentJson);
      expect(messageContent, isA<ArbitraryMessageContent>());
    });
  });
}
