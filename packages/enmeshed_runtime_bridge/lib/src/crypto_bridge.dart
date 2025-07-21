import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:cal_flutter_plugin/cal_flutter_plugin.dart';

class TsDartCryptoBridgeException implements Exception {
  final String value;
  final String type;
  String? json;
  TsDartCryptoBridgeException(this.type, this.value);

  void addJsonContext(String json) => this.json = json;

  @override
  String toString() {
    if (json == null) {
      return 'TsDartCryptoBridgeException: (Kind: $type). Unknown Value: $value';
    } else {
      return 'TsDartCryptoBridgeException: (Kind: $type). Unknown Value: $value\nPassed JSON:\n$json';
    }
  }
}

class CryptoHandler {
  static CryptoHandler? _instance;

  factory CryptoHandler() => _instance ??= CryptoHandler._internal();

  CryptoHandler._internal() {
    RustLib.init();
  }

  final HashMap<String, Provider> _providers = HashMap();
  final HashMap<String, KeyHandle> _keyHandles = HashMap();
  final HashMap<String, KeyPairHandle> _keyPairHandles = HashMap();
  final HashMap<String, DhExchange> _dhExchangeHandles = HashMap();

  Future<String> handleCall(List<dynamic> args) async {
    // the Call object is a JSON string with the following structure:
    // {
    //   "object_type": "bare" | "provider" | "key" | "key_pair",
    //   "object_id": string | null,
    //   "method": string,
    //   "args": List<dynamic>
    // }

    // the returned object always has one of these two forms:
    // {
    //    "status": "ok"
    //    "data": object
    // }
    //
    // {
    //    "status": "error"
    //    "message" : string
    // }

    if (args.length != 1) {
      throw TsDartCryptoBridgeException('not exactly 1 arg passed to handle', args.length.toString());
    }
    if (args[0] is! String) {
      throw TsDartCryptoBridgeException('the argument passed to the handle is not a string', args[0].toString());
    }

    final String callObj = args[0];

    final Map<String, dynamic> objMap = jsonDecode(callObj);
    try {
      final Object? returnedMap = switch (objMap['object_type']) {
        'bare' => await _handleBareCall(objMap),
        'provider' => await _handleProviderCall(objMap),
        'key' => await _handleKeyCall(objMap),
        'key_pair' => await _handleKeyPairCall(objMap),
        'dh_exchange' => await _handleDhExchangeCall(objMap),
        _ => throw TsDartCryptoBridgeException('Unkown handle type', objMap['object_type']),
      };
      return jsonEncode({'status': 'ok', 'data': returnedMap});
    } on TsDartCryptoBridgeException catch (e) {
      e.addJsonContext(callObj);
      return jsonEncode({'status': 'error', 'message': e.toString()});
    } catch (e) {
      return jsonEncode({'status': 'error', 'message': e.toString()});
    }
  }

  Future<Object> _handleBareCall(Map<String, dynamic> objMap) async {
    switch (objMap['method']) {
      case 'create_provider':
        final conf = decodeProviderConfig(objMap['args'][0]);
        final implConfig = await decodeProviderImplConfig(objMap['args'][1]);
        final provider = await createProvider(conf: conf, implConf: implConfig);
        final providerName = await provider!.providerName();
        _providers[providerName] = provider;
        return providerName;
      case 'create_provider_from_name':
        final String name = objMap['args'][0];
        final implConfig = await decodeProviderImplConfig(objMap['args'][1]);
        final provider = await createProviderFromName(name: name, implConf: implConfig);
        if (provider == null) {
          throw TsDartCryptoBridgeException('Provider not found', name);
        }
        final providerName = await provider.providerName();
        _providers[providerName] = provider;
        return providerName;
      case 'get_all_providers':
        final providers = await getAllProviders();
        return providers;
      case 'get_provider_capabilities':
        final implConfig = await decodeProviderImplConfig(objMap['args'][0]);
        final capabilities = await getProviderCapabilities(implConfig: implConfig);
        return capabilities.map((e) => [e.$1, encodeProviderConfig(e.$2)]).toList();
      default:
        throw TsDartCryptoBridgeException('Unknown method', objMap['method']);
    }
  }

  Future<Object> _handleProviderCall(Map<String, dynamic> objMap) async {
    final provider = _providers[objMap['object_id']]!;
    switch (objMap['method']) {
      case 'create_key':
        final keySpec = decodeKeySpec(objMap['args'][0]);
        final key = await provider.createKey(spec: keySpec);
        final keyId = await key.id();
        _keyHandles[keyId] = key;
        return keyId;
      case 'create_key_pair':
        final keySpec = decodeKeyPairSpec(objMap['args'][0]);
        final keyPair = await provider.createKeyPair(spec: keySpec);
        final keyPairId = await keyPair.id();
        _keyPairHandles[keyPairId] = keyPair;
        return keyPairId;
      case 'load_key':
        final keyId = objMap['args'][0];
        final key = await provider.loadKey(id: keyId);
        _keyHandles[keyId] = key;
        return keyId;
      case 'load_key_pair':
        final keyPairId = objMap['args'][0];
        final keyPair = await provider.loadKeyPair(id: keyPairId);
        _keyPairHandles[keyPairId] = keyPair;
        return keyPairId;
      case 'import_key':
        final keySpec = decodeKeySpec(objMap['args'][0]);
        final keyDataBase64 = objMap['args'][1];
        final keyData = base64Decode(keyDataBase64);
        final key = await provider.importKey(spec: keySpec, data: keyData);
        final keyId = await key.id();
        _keyHandles[keyId] = key;
        return keyId;
      case 'import_key_pair':
        final keyPairSpec = decodeKeyPairSpec(objMap['args'][0]);
        final publicKeyDataBase64 = objMap['args'][1];
        final publicKeyData = base64Decode(publicKeyDataBase64);
        final privateKeyDataBase64 = objMap['args'][2];
        final privateKeyData = base64Decode(privateKeyDataBase64);
        final keyPair = await provider.importKeyPair(spec: keyPairSpec, publicKey: publicKeyData, privateKey: privateKeyData);
        final keyPairId = await keyPair.id();
        _keyPairHandles[keyPairId] = keyPair;
        return keyPairId;
      case 'import_public_key':
        final keySpec = decodeKeyPairSpec(objMap['args'][0]);
        final keyDataBase64 = objMap['args'][1];
        final keyData = base64Decode(keyDataBase64);
        final key = await provider.importPublicKey(spec: keySpec, publicKey: keyData);
        final keyId = await key.id();
        _keyPairHandles[keyId] = key;
        return keyId;
      case 'start_ephemeral_dh_exchange':
        final keyPairSpec = decodeKeyPairSpec(objMap['args'][0]);
        final dhExchange = await provider.startEphemeralDhExchange(spec: keyPairSpec);
        final dhExchangeId = await dhExchange.id();
        _dhExchangeHandles[dhExchangeId] = dhExchange;
        return dhExchangeId;
      case 'dh_exchange_from_keys':
        final publicKey = base64Decode(objMap['args'][0]);
        final privateKey = base64Decode(objMap['args'][1]);
        final spec = decodeKeyPairSpec(objMap['args'][2]);
        final dhExchange = await provider.dhExchangeFromKeys(publicKey: publicKey, privateKey: privateKey, spec: spec);
        final dhExchangeId = await dhExchange.id();
        _dhExchangeHandles[dhExchangeId] = dhExchange;
        return dhExchangeId;
      case 'get_all_keys':
        final keys = await provider.getAllKeys();
        final encodedKeys = keys.map((val) {
          final (id, spec) = val;
          final encodedSpec = switch (spec) {
            final Spec_KeySpec s => encodeKeySpec(s.field0),
            final Spec_KeyPairSpec s => encodeKeyPairSpec(s.field0),
          };
          return {'id': id, 'spec': encodedSpec};
        }).toList();
        return encodedKeys;
      case 'provider_name':
        return await provider.providerName();
      case 'get_capabilities':
        final config = await provider.getCapabilities();
        if (config == null) {
          return 'null';
        }
        return encodeProviderConfig(config);
      case 'derive_key_from_password':
        final password = objMap['args'][0];
        final salt = base64Decode(objMap['args'][1]);
        final spec = decodeKeySpec(objMap['args'][2]);
        final kdf = decodeKdf(objMap['args'][3]);
        final key = await provider.deriveKeyFromPassword(password: password, salt: salt, algorithm: spec, kdf: kdf);
        final keyId = await key.id();
        _keyHandles[keyId] = key;
        return keyId;
      case 'derive_key_from_base':
        final baseKey = base64Decode(objMap['args'][0]);
        final keyId = objMap['args'][1];
        final context = objMap['args'][2];
        final spec = decodeKeySpec(objMap['args'][3]);
        final key = await provider.deriveKeyFromBase(baseKey: baseKey, keyId: keyId, context: context, spec: spec);
        final keyIdOut = await key.id();
        _keyHandles[keyIdOut] = key;
        return keyId;
      case 'hash':
        final input = base64Decode(objMap['args'][0]);
        final hashKind = decodeCryptoHash(objMap['args'][1]);
        final hash = await provider.hash(input: input, hash: hashKind);
        return base64Encode(hash);
      case 'get_random':
        final len = objMap['args'][0];
        final random = await provider.getRandom(len: BigInt.from(len));
        return base64Encode(random);
      default:
        throw TsDartCryptoBridgeException('Unknown method', objMap['method']);
    }
  }

  Future<Object> _handleKeyCall(Map<String, dynamic> objMap) async {
    final key = _keyHandles[objMap['object_id']]!;
    switch (objMap['method']) {
      case 'id':
        return await key.id();
      case 'extract_key':
        final keyData = await key.extractKey();
        return base64Encode(keyData);
      case 'encrypt_data':
        final dataBase64 = objMap['args'][0];
        final ivBase64 = objMap['args'][1];
        final data = base64Decode(dataBase64);
        final iv = base64Decode(ivBase64);
        final (dataOut, ivOut) = await key.encryptData(data: data, iv: iv);
        return {'data': base64Encode(dataOut), 'iv': base64Encode(ivOut)};
      case 'encrypt':
        final dataBase64 = objMap['args'][0];
        final data = base64Decode(dataBase64);
        final (dataOut, ivOut) = await key.encrypt(data: data);
        return {'data': base64Encode(dataOut), 'iv': base64Encode(ivOut)};
      case 'encrypt_with_iv':
        final dataBase64 = objMap['args'][0];
        final ivBase64 = objMap['args'][1];
        final data = base64Decode(dataBase64);
        final iv = base64Decode(ivBase64);
        final dataOut = await key.encryptWithIv(data: data, iv: iv);
        return base64Encode(dataOut);
      case 'decrypt_data':
        final dataBase64 = objMap['args'][0];
        final ivBase64 = objMap['args'][1];
        final data = base64Decode(dataBase64);
        final iv = base64Decode(ivBase64);
        final dataOut = await key.decryptData(encryptedData: data, iv: iv);
        return base64Encode(dataOut);
      case 'hmac':
        final dataBase64 = objMap['args'][0];
        final data = base64Decode(dataBase64);
        final hmac = await key.hmac(data: data);
        return base64Encode(hmac);
      case 'verify_hmac':
        final dataBase64 = objMap['args'][0];
        final hmacBase64 = objMap['args'][1];
        final data = base64Decode(dataBase64);
        final hmac = base64Decode(hmacBase64);
        final verified = await key.verifyHmac(data: data, hmac: hmac);
        return verified;
      case 'derive_key':
        final nonceBase64 = objMap['args'][0];
        final nonce = base64Decode(nonceBase64);
        final derivedKey = await key.deriveKey(nonce: nonce);
        final derivedKeyId = await derivedKey.id();
        _keyHandles[derivedKeyId] = derivedKey;
        return derivedKeyId;
      case 'delete':
        await key.delete();
        _keyHandles.remove(objMap['object_id']);
        return 'null';
      case 'spec':
        final spec = await key.spec();
        return encodeKeySpec(spec);
      default:
        throw TsDartCryptoBridgeException('Unknown method', objMap['method']);
    }
  }

  Future<Object?> _handleKeyPairCall(Map<String, dynamic> objMap) async {
    final keyPair = _keyPairHandles[objMap['object_id']]!;
    switch (objMap['method']) {
      case 'id':
        return await keyPair.id();
      case 'encrypt_data':
        final dataBase64 = objMap['args'][0];
        final data = base64Decode(dataBase64);
        final dataOut = await keyPair.encryptData(data: data);
        return base64Encode(dataOut);
      case 'decrypt_data':
        final dataBase64 = objMap['args'][0];
        final data = base64Decode(dataBase64);
        final dataOut = await keyPair.decryptData(data: data);
        return base64Encode(dataOut);
      case 'sign_data':
        final dataBase64 = objMap['args'][0];
        final data = base64Decode(dataBase64);
        final signature = await keyPair.signData(data: data);
        return base64Encode(signature);
      case 'verify_signature':
        final dataBase64 = objMap['args'][0];
        final signatureBase64 = objMap['args'][1];
        final data = base64Decode(dataBase64);
        final signature = base64Decode(signatureBase64);
        final verified = await keyPair.verifySignature(data: data, signature: signature);
        return verified;
      case 'start_dh_exchange':
        final dhExchange = await keyPair.startDhExchange();
        final dhExchangeId = await dhExchange.id();
        _dhExchangeHandles[dhExchangeId] = dhExchange;
        return dhExchangeId;
      case 'delete':
        await keyPair.delete();
        _keyPairHandles.remove(objMap['object_id']);
        return null;
      case 'get_public_key':
        final publicKey = await keyPair.getPublicKey();
        return base64Encode(publicKey);
      case 'spec':
        final spec = await keyPair.spec();
        return encodeKeyPairSpec(spec);
      default:
        throw TsDartCryptoBridgeException('Unknown method', objMap['method']);
    }
  }

  Future<Object?> _handleDhExchangeCall(Map<String, dynamic> objMap) async {
    final dhExchange = _dhExchangeHandles[objMap['object_id']]!;
    switch (objMap['method']) {
      case 'get_public_key':
        final publicKey = await dhExchange.getPublicKey();
        return base64Encode(publicKey);
      case 'derive_client_session_keys':
        final dataBase64 = objMap['args'][0];
        final data = base64Decode(dataBase64);
        final (rx, tx) = await dhExchange.deriveClientSessionKeys(serverPk: data);
        return [base64Encode(rx), base64Encode(tx)];
      case 'derive_server_session_keys':
        final dataBase64 = objMap['args'][0];
        final data = base64Decode(dataBase64);
        final (rx, tx) = await dhExchange.deriveServerSessionKeys(clientPk: data);
        return [base64Encode(rx), base64Encode(tx)];
      case 'derive_client_key_handles':
        final dataBase64 = objMap['args'][0];
        final data = base64Decode(dataBase64);
        final (rxHandle, txHandle) = await dhExchange.deriveClientKeyHandles(serverPk: data);
        final rxHandleId = await rxHandle.id();
        final txHandleId = await txHandle.id();
        _keyHandles[rxHandleId] = rxHandle;
        _keyHandles[txHandleId] = txHandle;
        return [rxHandleId, txHandleId];
      case 'derive_server_key_handles':
        final dataBase64 = objMap['args'][0];
        final data = base64Decode(dataBase64);
        final (rxHandle, txHandle) = await dhExchange.deriveServerKeyHandles(clientPk: data);
        final rxHandleId = await rxHandle.id();
        final txHandleId = await txHandle.id();
        _keyHandles[rxHandleId] = rxHandle;
        _keyHandles[txHandleId] = txHandle;
        return [rxHandleId, txHandleId];
      default:
        throw TsDartCryptoBridgeException('Unknown method', objMap['method']);
    }
  }

  ProviderConfig decodeProviderConfig(Map<String, dynamic> map) {
    final maxSecurityLevel = decodeSecurityLevel(map['max_security_level']);
    final minSecurityLevel = decodeSecurityLevel(map['min_security_level']);
    final supportedCiphers = map['supported_ciphers'].map((e) => decodeCipher(e)).toList().cast<Cipher>();
    final supportedHashes = map['supported_hashes'].map((e) => decodeCryptoHash(e)).toList().cast<CryptoHash>();
    final supportedAsymSpec = map['supported_asym_spec'].map((e) => decodeAsymmetricKeySpec(e)).toList().cast<AsymmetricKeySpec>();
    return ProviderConfig(
      maxSecurityLevel: maxSecurityLevel,
      minSecurityLevel: minSecurityLevel,
      supportedCiphers: supportedCiphers.toSet(),
      supportedHashes: supportedHashes.toSet(),
      supportedAsymSpec: supportedAsymSpec.toSet(),
    );
  }

  Map<String, Object> encodeProviderConfig(ProviderConfig config) {
    return {
      'max_security_level': encodeSecurityLevel(config.maxSecurityLevel),
      'min_security_level': encodeSecurityLevel(config.minSecurityLevel),
      'supported_ciphers': config.supportedCiphers.map((e) => encodeCipher(e)).toList().cast<String>(),
      'supported_hashes': config.supportedHashes.map((e) => encodeCryptoHash(e)).toList().cast<String>(),
      'supported_asym_spec': config.supportedAsymSpec.map((e) => encodeAsymmetricKeySpec(e)).toList().cast<String>(),
    };
  }

  SecurityLevel decodeSecurityLevel(String json) {
    switch (json) {
      case 'Hardware':
        return SecurityLevel.hardware;
      case 'Software':
        return SecurityLevel.software;
      case 'Network':
        return SecurityLevel.network;
      default:
        throw TsDartCryptoBridgeException('Unknown security level', json);
    }
  }

  String encodeSecurityLevel(SecurityLevel level) {
    switch (level) {
      case SecurityLevel.hardware:
        return 'Hardware';
      case SecurityLevel.software:
        return 'Software';
      case SecurityLevel.network:
        return 'Network';
      default:
        throw TsDartCryptoBridgeException('Unknown security level', level.toString());
    }
  }

  Cipher decodeCipher(String json) {
    switch (json) {
      case 'AesGcm128':
        return Cipher.aesGcm128;
      case 'AesGcm256':
        return Cipher.aesGcm256;
      case 'AesCbc128':
        return Cipher.aesCbc128;
      case 'AesCbc256':
        return Cipher.aesCbc256;
      case 'ChaCha20Poly1305':
        return Cipher.chaCha20Poly1305;
      case 'XChaCha20Poly1305':
        return Cipher.xChaCha20Poly1305;
      default:
        throw TsDartCryptoBridgeException('Unknown cipher', json);
    }
  }

  String encodeCipher(Cipher cipher) {
    switch (cipher) {
      case Cipher.aesGcm128:
        return 'AesGcm128';
      case Cipher.aesGcm256:
        return 'AesGcm256';
      case Cipher.aesCbc128:
        return 'AesCbc128';
      case Cipher.aesCbc256:
        return 'AesCbc256';
      case Cipher.chaCha20Poly1305:
        return 'ChaCha20Poly1305';
      case Cipher.xChaCha20Poly1305:
        return 'XChaCha20Poly1305';
    }
  }

  CryptoHash decodeCryptoHash(String json) {
    switch (json) {
      case 'Sha2_224':
        return CryptoHash.sha2224;
      case 'Sha2_256':
        return CryptoHash.sha2256;
      case 'Sha2_384':
        return CryptoHash.sha2384;
      case 'Sha2_512':
        return CryptoHash.sha2512;
      case 'Sha2_512_224':
        return CryptoHash.sha2512224;
      case 'Sha2_512_256':
        return CryptoHash.sha2512256;
      case 'Sha3_224':
        return CryptoHash.sha3224;
      case 'Sha3_256':
        return CryptoHash.sha3256;
      case 'Sha3_384':
        return CryptoHash.sha3384;
      case 'Sha3_512':
        return CryptoHash.sha3512;
      case 'Blake2B':
        return CryptoHash.blake2B;
      default:
        throw TsDartCryptoBridgeException('Unknown hash', json);
    }
  }

  String encodeCryptoHash(CryptoHash hash) {
    switch (hash) {
      case CryptoHash.sha2224:
        return 'Sha2_224';
      case CryptoHash.sha2256:
        return 'Sha2_256';
      case CryptoHash.sha2384:
        return 'Sha2_384';
      case CryptoHash.sha2512:
        return 'Sha2_512';
      case CryptoHash.sha2512224:
        return 'Sha2_512_224';
      case CryptoHash.sha2512256:
        return 'Sha2_512_256';
      case CryptoHash.sha3224:
        return 'Sha3_224';
      case CryptoHash.sha3256:
        return 'Sha3_256';
      case CryptoHash.sha3384:
        return 'Sha3_384';
      case CryptoHash.sha3512:
        return 'Sha3_512';
      case CryptoHash.blake2B:
        return 'Blake2B';
    }
  }

  AsymmetricKeySpec decodeAsymmetricKeySpec(String json) {
    switch (json) {
      case 'RSA1024':
        return AsymmetricKeySpec.rsa1024;
      case 'RSA2048':
        return AsymmetricKeySpec.rsa2048;
      case 'RSA3072':
        return AsymmetricKeySpec.rsa3072;
      case 'RSA4096':
        return AsymmetricKeySpec.rsa4096;
      case 'RSA8192':
        return AsymmetricKeySpec.rsa8192;
      case 'P256':
        return AsymmetricKeySpec.p256;
      case 'P384':
        return AsymmetricKeySpec.p384;
      case 'P521':
        return AsymmetricKeySpec.p521;
      case 'Secp256K1':
        return AsymmetricKeySpec.secp256K1;
      case 'BrainpoolP256R1':
        return AsymmetricKeySpec.brainpoolP256R1;
      case 'BrainpoolP384R1':
        return AsymmetricKeySpec.brainpoolP384R1;
      case 'BrainpoolP512R1':
        return AsymmetricKeySpec.brainpoolP512R1;
      case 'BrainpoolP638':
        return AsymmetricKeySpec.brainpoolP638;
      case 'Curve25519':
        return AsymmetricKeySpec.curve25519;
      case 'Curve448':
        return AsymmetricKeySpec.curve448;
      case 'Frp256V1':
        return AsymmetricKeySpec.frp256V1;
      default:
        throw TsDartCryptoBridgeException('Unknown asymmetric key spec', json);
    }
  }

  String encodeAsymmetricKeySpec(AsymmetricKeySpec spec) {
    switch (spec) {
      case AsymmetricKeySpec.rsa1024:
        return 'RSA1024';
      case AsymmetricKeySpec.rsa2048:
        return 'RSA2048';
      case AsymmetricKeySpec.rsa3072:
        return 'RSA3072';
      case AsymmetricKeySpec.rsa4096:
        return 'RSA4096';
      case AsymmetricKeySpec.rsa8192:
        return 'RSA8192';
      case AsymmetricKeySpec.p256:
        return 'P256';
      case AsymmetricKeySpec.p384:
        return 'P384';
      case AsymmetricKeySpec.p521:
        return 'P521';
      case AsymmetricKeySpec.secp256K1:
        return 'Secp256K1';
      case AsymmetricKeySpec.brainpoolP256R1:
        return 'BrainpoolP256R1';
      case AsymmetricKeySpec.brainpoolP384R1:
        return 'BrainpoolP384R1';
      case AsymmetricKeySpec.brainpoolP512R1:
        return 'BrainpoolP512R1';
      case AsymmetricKeySpec.brainpoolP638:
        return 'BrainpoolP638';
      case AsymmetricKeySpec.curve25519:
        return 'Curve25519';
      case AsymmetricKeySpec.curve448:
        return 'Curve448';
      case AsymmetricKeySpec.frp256V1:
        return 'Frp256V1';
    }
  }

  Future<ProviderImplConfig> decodeProviderImplConfig(Map<String, dynamic> map) async {
    final List<AdditionalConfig> additionalConfigs = map['additional_config'].map((e) => decodeAdditionalConfig(e)).toList().cast<AdditionalConfig>();

    // inject DB store config. This has to be done on the Dart side, because the JS side cannot get the right Paths.
    // final dir = await getApplicationSupportDirectory();

    // additionalConfigs.add(AdditionalConfig_FileStoreConfig(dbDir: dir.path));

    return ProviderImplConfig(additionalConfig: additionalConfigs);
  }

  Map<String, dynamic> encodeProviderImplConfig(ProviderImplConfig config) {
    return {'additional_config': config.additionalConfig.map((e) => encodeAdditionalConfig(e)).toList()};
  }

  AdditionalConfig decodeAdditionalConfig(Map<String, dynamic> map) {
    if (map['FileStoreConfig'] != null) {
      return AdditionalConfig.fileStoreConfig(dbDir: map['FileStoreConfig']['db_dir']);
    } else if (map['StorageConfigHMAC'] != null) {
      final keyHandle = _keyHandles[map['StorageConfigHMAC']['_id']]!;
      return AdditionalConfig.storageConfigHmac(keyHandle);
    } else if (map['StorageConfigDSA'] != null) {
      final keyPairHandle = _keyPairHandles[map['StorageConfigDSA']['_id']]!;
      return AdditionalConfig.storageConfigDsa(keyPairHandle);
    } else if (map['StorageConfigSymmetricEncryption'] != null) {
      final keyHandle = _keyHandles[map['StorageConfigSymmetricEncryption']['_id']]!;
      return AdditionalConfig.storageConfigSymmetricEncryption(keyHandle);
    } else if (map['StorageConfigAsymmetricEncryption'] != null) {
      final keyPairHandle = _keyPairHandles[map['StorageConfigAsymmetricEncryption']['_id']]!;
      return AdditionalConfig.storageConfigAsymmetricEncryption(keyPairHandle);
    } else {
      throw TsDartCryptoBridgeException('Unknown additional config type', map.keys.toString());
    }
  }

  Map<String, dynamic> encodeAdditionalConfig(AdditionalConfig config) {
    switch (config) {
      case AdditionalConfig_FileStoreConfig(:final dbDir):
        return {'FileStoreConfig': dbDir};
      case AdditionalConfig_StorageConfigHMAC(:final field0):
        return {'StorageConfigHMAC': field0};
      case AdditionalConfig_StorageConfigDSA(:final field0):
        return {'StorageConfigDSA': field0};
      case AdditionalConfig_StorageConfigSymmetricEncryption(:final field0):
        return {'StorageConfigSymmetricEncryption': field0};
      case AdditionalConfig_StorageConfigAsymmetricEncryption(:final field0):
        return {'StorageConfigAsymmetricEncryption': field0};
      default:
        throw TsDartCryptoBridgeException('Unknown additional config type', config.runtimeType.toString());
    }
  }

  KeySpec decodeKeySpec(Map<String, dynamic> map) {
    final cipher = decodeCipher(map['cipher']);
    final signingHash = decodeCryptoHash(map['signing_hash']);
    return KeySpec(cipher: cipher, signingHash: signingHash, ephemeral: map['ephemeral'], nonExportable: map['non_exportable']);
  }

  Map<String, dynamic> encodeKeySpec(KeySpec spec) {
    return {'cipher': encodeCipher(spec.cipher), 'signing_hash': encodeCryptoHash(spec.signingHash), 'ephemeral': spec.ephemeral};
  }

  KeyPairSpec decodeKeyPairSpec(Map<String, dynamic> map) {
    final asymSpec = decodeAsymmetricKeySpec(map['asym_spec']);
    final cipher = map['cipher'] == null ? null : decodeCipher(map['cipher']);
    final signingHash = decodeCryptoHash(map['signing_hash']);
    return KeyPairSpec(
      asymSpec: asymSpec,
      cipher: cipher,
      signingHash: signingHash,
      ephemeral: map['ephemeral'],
      nonExportable: map['non_exportable'],
    );
  }

  Map<String, dynamic> encodeKeyPairSpec(KeyPairSpec spec) {
    return {
      'asym_spec': encodeAsymmetricKeySpec(spec.asymSpec),
      'cipher': spec.cipher == null ? null : encodeCipher(spec.cipher!),
      'signing_hash': encodeCryptoHash(spec.signingHash),
      'ephemeral': spec.ephemeral,
      'non_exportable': spec.nonExportable,
    };
  }

  Argon2Options decodeArgon2Options(Map<String, dynamic> map) {
    final memory = map['memory'];
    final iterations = map['iterations'];
    final parallelism = map['parallelism'];
    return Argon2Options(memory: memory, iterations: iterations, parallelism: parallelism);
  }

  Map<String, dynamic> encodeArgon2Options(Argon2Options options) {
    return {'memory': options.memory, 'iterations': options.iterations, 'parallelism': options.parallelism};
  }

  KDF decodeKdf(Map<String, dynamic> map) {
    if (map['Argon2d'] != null) {
      return KDF.argon2D(decodeArgon2Options(map['Argon2d']));
    } else if (map['Argon2id'] != null) {
      return KDF.argon2Id(decodeArgon2Options(map['Argon2id']));
    } else if (map['Argon2i'] != null) {
      return KDF.argon2I(decodeArgon2Options(map['Argon2i']));
    } else {
      throw TsDartCryptoBridgeException('Unknown KDF type', map.keys.toString());
    }
  }

  Map<String, dynamic> encodeKdf(KDF kdf) {
    switch (kdf) {
      case KDF_Argon2d(:final field0):
        return {'Argon2d': encodeArgon2Options(field0)};
      case KDF_Argon2id(:final field0):
        return {'Argon2id': encodeArgon2Options(field0)};
      case KDF_Argon2i(:final field0):
        return {'Argon2i': encodeArgon2Options(field0)};
    }
  }
}
