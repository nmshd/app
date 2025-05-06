import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';
import '../../../utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late Session session;
  late TokenDTO uploadedToken;

  setUpAll(() async {
    final account1 = await runtime.accountServices.createAccount(name: 'tokensFacade Test 1');
    session = runtime.getSession(account1.id);

    final result = await session.transportServices.tokens.createOwnToken(
      content: {'test': 'test'},
      expiresAt: generateExpiryString(),
      ephemeral: true,
    );
    uploadedToken = result.value;
  });

  group('[AnonymousTokensFacade]', () {
    test('should load a Token by truncatedReference', () async {
      final result = await runtime.anonymousServices.tokens.loadPeerToken(uploadedToken.truncatedReference);
      expect(result, isSuccessful<TokenDTO>());

      final token = result.value;
      expect(token.id, equals(uploadedToken.id));
      expect(token.content, equals(uploadedToken.content));
    });
  });
}
