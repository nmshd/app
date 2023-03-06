import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final mail = Mail(body: 'A Body', subject: 'A Subject', to: ['A Recipient']);

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(mail.body, equals('A Body'));
      expect(mail.toJson()['body'], equals('A Body'));
    });
  });
}
