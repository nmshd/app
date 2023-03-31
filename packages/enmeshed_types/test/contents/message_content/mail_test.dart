import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Mail toJson', () {
    test('is correctly converted', () {
      const mail = Mail(to: ['test@test.com'], subject: 'aSubject', body: 'aBody');
      final mailJson = mail.toJson();
      expect(
        mailJson,
        equals({
          '@type': 'Mail',
          'to': ['test@test.com'],
          'subject': 'aSubject',
          'body': 'aBody',
        }),
      );
    });

    test('is correctly converted with property "cc"', () {
      const mail = Mail(to: ['test@test.com'], cc: ['test2@test.com'], subject: 'aSubject', body: 'aBody');
      final mailJson = mail.toJson();
      expect(
        mailJson,
        equals({
          '@type': 'Mail',
          'to': ['test@test.com'],
          'cc': ['test2@test.com'],
          'subject': 'aSubject',
          'body': 'aBody',
        }),
      );
    });
  });

  group('Mail fromJson', () {
    test('is correctly converted', () {
      const mail = Mail(to: ['test@test.com'], subject: 'aSubject', body: 'aBody');
      final json = {
        'to': ['test@test.com'],
        'subject': 'aSubject',
        'body': 'aBody',
      };
      expect(Mail.fromJson(json), equals(mail));
    });

    test('is correctly converted with property "cc"', () {
      const mail = Mail(to: ['test@test.com'], cc: ['test2@test.com'], subject: 'aSubject', body: 'aBody');
      final json = {
        'to': ['test@test.com'],
        'cc': ['test2@test.com'],
        'subject': 'aSubject',
        'body': 'aBody',
      };
      expect(Mail.fromJson(json), equals(mail));
    });
  });
}
