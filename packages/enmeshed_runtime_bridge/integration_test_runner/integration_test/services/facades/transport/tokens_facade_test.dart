import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';
import '../../../utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late Session session1;
  late Session session2;
  late String addressSession2;

  setUpAll(() async {
    final account1 = await runtime.accountServices.createAccount(name: 'tokensFacade Test 1');
    session1 = runtime.getSession(account1.id);

    final account2 = await runtime.accountServices.createAccount(name: 'tokensFacade Test 2');
    session2 = runtime.getSession(account2.id);
    addressSession2 = (await session2.transportServices.account.getIdentityInfo()).value.address;
  });

  group('[TokensFacade] createOwnToken', () {
    test('should create a Token', () async {
      final expiry = generateExpiryString();

      final token = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: expiry,
        ephemeral: false,
        forIdentity: addressSession2,
      );

      expect(token, isSuccessful<TokenDTO>());
      expect(token.value.content, equals({'test': 'test'}));
      expect(token.value.expiresAt, equals(expiry));
      expect(token.value.forIdentity, equals(addressSession2));
    });

    test('should create an ephermeral Token', () async {
      final createTokenResult = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: generateExpiryString(),
        ephemeral: true,
      );

      await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: generateExpiryString(),
        ephemeral: true,
      );

      final result = await session1.transportServices.tokens.getToken(createTokenResult.value.id);
      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('[TokensFacade] loadPeerToken', () {
    test('should load a Token', () async {
      final expiry = generateExpiryString();

      final token = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: expiry,
        ephemeral: true,
      );

      final peerToken = await session2.transportServices.tokens.loadPeerToken(
        reference: token.value.truncatedReference,
        ephemeral: false,
      );

      expect(peerToken, isSuccessful<TokenDTO>());
      expect(peerToken.value.content, equals({'test': 'test'}));
      expect(peerToken.value.expiresAt, equals(expiry));
    });

    test('should load a Token ephemeral', () async {
      final expiry = generateExpiryString();

      final token = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: expiry,
        ephemeral: true,
      );

      final peerToken = await session2.transportServices.tokens.loadPeerToken(
        reference: token.value.truncatedReference,
        ephemeral: true,
      );

      expect(peerToken, isSuccessful<TokenDTO>());
      expect(peerToken.value.content, equals({'test': 'test'}));
      expect(peerToken.value.expiresAt, equals(expiry));

      final result = await session2.transportServices.tokens.getToken(token.value.id);
      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('[TokensFacade] getTokens', () {
    test('should return all Tokens', () async {
      final newToken = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: generateExpiryString(),
        ephemeral: false,
      );

      final getTokensResult = await session1.transportServices.tokens.getTokens();

      expect(getTokensResult, isSuccessful<List<TokenDTO>>());
      expect(getTokensResult.value, contains(newToken.value));
    });

    test('should return all Tokens for an Identity', () async {
      final tokenForIdentity = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: generateExpiryString(),
        ephemeral: false,
        forIdentity: addressSession2,
      );

      final getTokensResult = await session1.transportServices.tokens.getTokens(
        query: {'forIdentity': QueryValue.string(addressSession2)},
      );

      expect(getTokensResult, isSuccessful<List<TokenDTO>>());
      expect(getTokensResult.value, contains(tokenForIdentity.value));
    });
  });

  group('[TokensFacade] getToken', () {
    test('should return a Token', () async {
      final token = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: generateExpiryString(),
        ephemeral: false,
      );

      final result = await session1.transportServices.tokens.getToken(token.value.id);

      expect(result, isSuccessful<TokenDTO>());
      expect(result.value, equals(token.value));
    });
  });
}
