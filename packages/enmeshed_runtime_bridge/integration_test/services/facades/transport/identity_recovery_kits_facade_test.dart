import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late LocalAccountDTO account;
  late Session session;

  setUpAll(() async {
    account = await runtime.accountServices.createAccount(name: 'IdentityRecoveryKitsFacade Test 1');
    session = runtime.getSession(account.id);
  });

  group('IdentityRecoveryKitsFacade', () {
    test('createIdentityRecoveryKit', () async {
      final identityRecoveryKitResult = await session.transportServices.identityRecoveryKits.createIdentityRecoveryKit(
        profileName: 'aProfileName',
        passwordProtection: PasswordProtection(password: 'aPassword'),
      );
      expect(identityRecoveryKitResult, isSuccessful<TokenDTO>());
    });

    test('checkForExistingIdentityRecoveryKit', () async {
      await session.transportServices.identityRecoveryKits.createIdentityRecoveryKit(
        profileName: 'aProfileName',
        passwordProtection: PasswordProtection(password: 'aPassword'),
      );

      final checkResult = await session.transportServices.identityRecoveryKits.checkForExistingIdentityRecoveryKit();
      expect(checkResult, isSuccessful<({bool exists})>());
      expect(checkResult.value.exists, true);
    });
  });
}
