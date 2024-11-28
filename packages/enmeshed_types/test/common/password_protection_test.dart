import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('PasswordProtection toJson', () {
    test('is correctly converted', () {
      const passwordProtection = PasswordProtection(password: 'aPassword');

      expect(passwordProtection.toJson(), equals({'password': 'aPassword'}));
    });

    test('is correctly converted with passwordIsPin \'null\'', () {
      const passwordProtection = PasswordProtection(password: 'aPassword', passwordIsPin: null);

      expect(passwordProtection.toJson(), equals({'password': 'aPassword'}));
    });

    test('is correctly converted with passwordIsPin \'true\'', () {
      const passwordProtection = PasswordProtection(password: 'aPassword', passwordIsPin: true);

      expect(passwordProtection.toJson(), equals({'password': 'aPassword', 'passwordIsPin': true}));
    });

    test('is correctly converted with passwordIsPin \'false\'', () {
      const passwordProtection = PasswordProtection(password: 'aPassword', passwordIsPin: false);

      expect(passwordProtection.toJson(), equals({'password': 'aPassword'}));
    });
  });
}
