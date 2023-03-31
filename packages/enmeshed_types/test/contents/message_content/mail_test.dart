import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Mail toJson', () {
    test('is correctly converted', () {
      const mail = Mail(to: ['aRecipient'], subject: 'aSubject', body: 'aBody');
      final mailJson = mail.toJson();
      expect(
        mailJson,
        equals({
          '@type': 'Mail',
          'to': ['aRecipient'],
          'subject': 'aSubject',
          'body': 'aBody',
        }),
      );
    });

    test('is correctly converted with property "cc"', () {
      const mail = Mail(to: ['aRecipient'], cc: ['copyRecipient'], subject: 'aSubject', body: 'aBody');
      final mailJson = mail.toJson();
      expect(
        mailJson,
        equals({
          '@type': 'Mail',
          'to': ['aRecipient'],
          'cc': ['copyRecipient'],
          'subject': 'aSubject',
          'body': 'aBody',
        }),
      );
    });
  });

  group('Mail fromJson', () {
    test('is correctly converted', () {
      final json = {
        'to': ['aRecipient'],
        'subject': 'aSubject',
        'body': 'aBody',
      };
      expect(Mail.fromJson(json), equals(const Mail(to: ['aRecipient'], subject: 'aSubject', body: 'aBody')));
    });

    test('is correctly converted with property "cc"', () {
      final json = {
        'to': ['aRecipient'],
        'cc': ['copyRecipient'],
        'subject': 'aSubject',
        'body': 'aBody',
      };
      expect(Mail.fromJson(json), equals(const Mail(to: ['aRecipient'], cc: ['copyRecipient'], subject: 'aSubject', body: 'aBody')));
    });
  });
}
