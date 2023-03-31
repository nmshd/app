import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    const mail = Mail(body: 'A Body', subject: 'A Subject', to: ['A Recipient']);

    test('First Test', () {
      expect(mail.body, equals('A Body'));
      expect(mail.toJson()['body'], equals('A Body'));
    });
  });
}
