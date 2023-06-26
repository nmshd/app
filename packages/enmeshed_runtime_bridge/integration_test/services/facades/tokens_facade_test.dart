import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers.dart';
import '../../setup.dart';
import '../../utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late Session session1;
  late Session session2;

  setUpAll(() async {
    final account1 = await runtime.accountServices.createAccount(name: 'tokensFacade Test 1');
    session1 = runtime.getSession(account1.id);

    final account2 = await runtime.accountServices.createAccount(name: 'tokensFacade Test 2');
    session2 = runtime.getSession(account2.id);
  });

  group('TokensFacade: createOwnToken', () {
    test('should create a Token', () async {
      final expiry = generateExpiryString();

      final token = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: expiry,
        ephemeral: false,
      );

      expect(token, isSuccessful<TokenDTO>());
      expect(token.value.content, equals({'test': 'test'}));
      expect(token.value.expiresAt, equals(expiry));
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

  group('TokensFacade: loadPeerTokenByIdAndKey', () {
    test('should load a token', () async {
      final expiry = generateExpiryString();

      final token = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: expiry,
        ephemeral: false,
      );

      final peerToken = await session2.transportServices.tokens.loadPeerTokenByIdAndKey(
        id: token.value.id,
        secretKey: token.value.secretKey,
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

      final peerToken = await session2.transportServices.tokens.loadPeerTokenByIdAndKey(
        id: token.value.id,
        secretKey: token.value.secretKey,
        ephemeral: true,
      );

      expect(peerToken, isSuccessful<TokenDTO>());
      expect(peerToken.value.content, equals({'test': 'test'}));
      expect(peerToken.value.expiresAt, equals(expiry));

      final result = await session2.transportServices.tokens.getToken(token.value.id);
      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('TokensFacade: loadPeerTokenByReference', () {
    test('should load a token', () async {
      final expiry = generateExpiryString();

      final token = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: expiry,
        ephemeral: true,
      );

      final peerToken = await session2.transportServices.tokens.loadPeerTokenByReference(
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

      final peerToken = await session2.transportServices.tokens.loadPeerTokenByReference(
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

  group('TokensFacade: getTokens', () {
    test('should return all tokens', () async {
      final token1 = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: generateExpiryString(),
        ephemeral: false,
      );

      final tokens = await session1.transportServices.tokens.getTokens();

      expect(tokens, isSuccessful<List<TokenDTO>>());
      expect(tokens.value, contains(token1.value));
    });
  });

  group('TokensFacade: getToken', () {
    test('should return a token', () async {
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

  group('TokensFacade: getQRCodeForToken', () {
    test('should return a QRCode', () async {
      final token = await session1.transportServices.tokens.createOwnToken(
        content: {'test': 'test'},
        expiresAt: generateExpiryString(),
        ephemeral: false,
      );

      final result = await session1.transportServices.tokens.getQRCodeForToken(token.value.id);

      expect(result, isSuccessful<CreateQrCodeResponse>());
    });
  });
}
