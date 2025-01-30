import 'dart:collection';
import 'dart:convert';

import 'package:cal_flutter_plugin/cal_flutter_plugin.dart';

class TsDartBridgeException implements Exception {
  final String value;
  final String type;
  String? json;
  TsDartBridgeException(this.type, this.value);

  void addJsonContext(String json) => this.json = json;

  @override
  String toString() {
    if (json == null) {
      return 'TsDartBridgeException: (Kind: $type). Unknown Value: $value';
    } else {
      return 'TsDartBridgeException: (Kind: $type). Unknown Value: $value\nPassed JSON:\n$json';
    }
  }
}

class CryptoHandler {
  static final CryptoHandler _singleton = CryptoHandler._internal();

  factory CryptoHandler() {
    return _singleton;
  }

  CryptoHandler._internal() {
    RustLib.init();
  }

  final HashMap<String, Provider> _providers = HashMap();
  final HashMap<String, KeyHandle> _keyHandles = HashMap();
  final HashMap<String, KeyPairHandle> _keyPairHandles = HashMap();

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
      throw TsDartBridgeException('not exactly 1 arg passed to handle', args.length.toString());
    }
    if (args[0] is! String) {
      throw TsDartBridgeException('the argument passed to the handle is not a string', args[0].toString());
    }

    final String callObj = args[0];

    final Map<String, dynamic> objMap = jsonDecode(callObj);
    try {
      final Object? returnedMap = switch (objMap['object_type']) {
        'bare' => await _handleBareCall(objMap),
        'provider' => await _handleProviderCall(objMap),
        'key' => await _handleKeyCall(objMap),
        'key_pair' => await _handleKeyPairCall(objMap),
        _ => throw TsDartBridgeException('Unkown handle type', objMap['object_type']),
      };
      return jsonEncode({'status': 'ok', 'data': returnedMap});
    } on TsDartBridgeException catch (e) {
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
        final implConfig = decodeProviderImplConfig(objMap['args'][1]);
        final provider = await createProvider(conf: conf, implConf: implConfig);
        final providerName = await provider!.providerName();
        _providers[providerName] = provider;
        return providerName;
      case 'create_provider_from_name':
        final String name = objMap['args'][0];
        final implConfig = decodeProviderImplConfig(objMap['args'][1]);
        final provider = await createProviderFromName(name: name, implConf: implConfig);
        final providerName = await provider!.providerName();
        _providers[providerName] = provider;
        return providerName;
      case 'get_all_providers':
        final providers = await getAllProviders();
        return providers;
      default:
        throw TsDartBridgeException('Unknown method', objMap['method']);
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
      default:
        throw TsDartBridgeException('Unknown method', objMap['method']);
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
        final data = base64Decode(dataBase64);
        final (dataOut, iv) = await key.encryptData(data: data);
        return {'data': base64Encode(dataOut), 'iv': iv};
      case 'decrypt_data':
        final dataBase64 = objMap['args'][0];
        final iv = objMap['args'][1];
        final data = base64Decode(dataBase64);
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
      case 'delete':
        await key.delete();
        _keyHandles.remove(objMap['object_id']);
        return 'null';
      case 'spec':
        final spec = await key.spec();
        return encodeKeySpec(spec);
      default:
        throw TsDartBridgeException('Unknown method', objMap['method']);
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
        throw TsDartBridgeException('Unknown method', objMap['method']);
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
        supportedAsymSpec: supportedAsymSpec.toSet());
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
      case 'HARDWARE':
        return SecurityLevel.hardware;
      case 'SOFTWARE':
        return SecurityLevel.software;
      case 'NETWORK':
        return SecurityLevel.network;
      default:
        throw TsDartBridgeException('Unknown security level', json);
    }
  }

  String encodeSecurityLevel(SecurityLevel level) {
    switch (level) {
      case SecurityLevel.hardware:
        return 'HARDWARE';
      case SecurityLevel.software:
        return 'SOFTWARE';
      case SecurityLevel.network:
        return 'NETWORK';
      default:
        throw TsDartBridgeException('Unknown security level', level.toString());
    }
  }

// aesGcm128,
// aesGcm256,
// aesCbc128,
// aesCbc256,
// chaCha20Poly1305,
// xChaCha20Poly1305,
  Cipher decodeCipher(String json) {
    switch (json) {
      case 'aesGcm128':
        return Cipher.aesGcm128;
      case 'aesGcm256':
        return Cipher.aesGcm256;
      case 'aesCbc128':
        return Cipher.aesCbc128;
      case 'aesCbc256':
        return Cipher.aesCbc256;
      case 'chaCha20Poly1305':
        return Cipher.chaCha20Poly1305;
      case 'xChaCha20Poly1305':
        return Cipher.xChaCha20Poly1305;
      default:
        throw TsDartBridgeException('Unknown cipher', json);
    }
  }

  String encodeCipher(Cipher cipher) {
    switch (cipher) {
      case Cipher.aesGcm128:
        return 'aesGcm128';
      case Cipher.aesGcm256:
        return 'aesGcm256';
      case Cipher.aesCbc128:
        return 'aesCbc128';
      case Cipher.aesCbc256:
        return 'aesCbc256';
      case Cipher.chaCha20Poly1305:
        return 'chaCha20Poly1305';
      case Cipher.xChaCha20Poly1305:
        return 'xChaCha20Poly1305';
    }
  }

// sha2224,
// sha2256,
// sha2384,
// sha2512,
// sha2512224,
// sha2512256,
// sha3224,
// sha3256,
// sha3384,
// sha3512,
  CryptoHash decodeCryptoHash(String json) {
    switch (json) {
      case 'sha2224':
        return CryptoHash.sha2224;
      case 'sha2256':
        return CryptoHash.sha2256;
      case 'sha2384':
        return CryptoHash.sha2384;
      case 'sha2512':
        return CryptoHash.sha2512;
      case 'sha2512224':
        return CryptoHash.sha2512224;
      case 'sha2512256':
        return CryptoHash.sha2512256;
      case 'sha3224':
        return CryptoHash.sha3224;
      case 'sha3256':
        return CryptoHash.sha3256;
      case 'sha3384':
        return CryptoHash.sha3384;
      case 'sha3512':
        return CryptoHash.sha3512;
      default:
        throw TsDartBridgeException('Unknown hash', json);
    }
  }

  String encodeCryptoHash(CryptoHash hash) {
    switch (hash) {
      case CryptoHash.sha2224:
        return 'sha2224';
      case CryptoHash.sha2256:
        return 'sha2256';
      case CryptoHash.sha2384:
        return 'sha2384';
      case CryptoHash.sha2512:
        return 'sha2512';
      case CryptoHash.sha2512224:
        return 'sha2512224';
      case CryptoHash.sha2512256:
        return 'sha2512256';
      case CryptoHash.sha3224:
        return 'sha3224';
      case CryptoHash.sha3256:
        return 'sha3256';
      case CryptoHash.sha3384:
        return 'sha3384';
      case CryptoHash.sha3512:
        return 'sha3512';
    }
  }

// rsa1024,
// rsa2048,
// rsa3072,
// rsa4096,
// rsa8192,
// p256,
// p384,
// p521,
// secp256K1,
// brainpoolP256R1,
// brainpoolP384R1,
// brainpoolP512R1,
// brainpoolP638,
// curve25519,
// curve448,
// frp256V1,

  AsymmetricKeySpec decodeAsymmetricKeySpec(String json) {
    switch (json) {
      case 'rsa1024':
        return AsymmetricKeySpec.rsa1024;
      case 'rsa2048':
        return AsymmetricKeySpec.rsa2048;
      case 'rsa3072':
        return AsymmetricKeySpec.rsa3072;
      case 'rsa4096':
        return AsymmetricKeySpec.rsa4096;
      case 'rsa8192':
        return AsymmetricKeySpec.rsa8192;
      case 'p256':
        return AsymmetricKeySpec.p256;
      case 'p384':
        return AsymmetricKeySpec.p384;
      case 'p521':
        return AsymmetricKeySpec.p521;
      case 'secp256K1':
        return AsymmetricKeySpec.secp256K1;
      case 'brainpoolP256R1':
        return AsymmetricKeySpec.brainpoolP256R1;
      case 'brainpoolP384R1':
        return AsymmetricKeySpec.brainpoolP384R1;
      case 'brainpoolP512R1':
        return AsymmetricKeySpec.brainpoolP512R1;
      case 'brainpoolP638':
        return AsymmetricKeySpec.brainpoolP638;
      case 'curve25519':
        return AsymmetricKeySpec.curve25519;
      case 'curve448':
        return AsymmetricKeySpec.curve448;
      case 'frp256V1':
        return AsymmetricKeySpec.frp256V1;
      default:
        throw TsDartBridgeException('Unknown asymmetric key spec', json);
    }
  }

  String encodeAsymmetricKeySpec(AsymmetricKeySpec spec) {
    switch (spec) {
      case AsymmetricKeySpec.rsa1024:
        return 'rsa1024';
      case AsymmetricKeySpec.rsa2048:
        return 'rsa2048';
      case AsymmetricKeySpec.rsa3072:
        return 'rsa3072';
      case AsymmetricKeySpec.rsa4096:
        return 'rsa4096';
      case AsymmetricKeySpec.rsa8192:
        return 'rsa8192';
      case AsymmetricKeySpec.p256:
        return 'p256';
      case AsymmetricKeySpec.p384:
        return 'p384';
      case AsymmetricKeySpec.p521:
        return 'p521';
      case AsymmetricKeySpec.secp256K1:
        return 'secp256K1';
      case AsymmetricKeySpec.brainpoolP256R1:
        return 'brainpoolP256R1';
      case AsymmetricKeySpec.brainpoolP384R1:
        return 'brainpoolP384R1';
      case AsymmetricKeySpec.brainpoolP512R1:
        return 'brainpoolP512R1';
      case AsymmetricKeySpec.brainpoolP638:
        return 'brainpoolP638';
      case AsymmetricKeySpec.curve25519:
        return 'curve25519';
      case AsymmetricKeySpec.curve448:
        return 'curve448';
      case AsymmetricKeySpec.frp256V1:
        return 'frp256V1';
    }
  }

  ProviderImplConfig decodeProviderImplConfig(Map<String, dynamic> map) {
    final additionalConfig = map['additional_config'].map((e) => decodeAdditionalConfig(e)).toList().cast<AdditionalConfig>();
    return ProviderImplConfig(additionalConfig: additionalConfig);
  }

  Map<String, dynamic> encodeProviderImplConfig(ProviderImplConfig config) {
    return {
      'additional_config': config.additionalConfig.map((e) => encodeAdditionalConfig(e)).toList(),
    };
  }

  AdditionalConfig decodeAdditionalConfig(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'FileStoreConfig':
        return AdditionalConfig.fileStoreConfig(dbDir: map['db_dir']);
      case 'StorageConfigHMAC':
        final keyHandle = _keyHandles[map['key_handle']]!;
        return AdditionalConfig.storageConfigHmac(keyHandle);
      case 'StorageConfigDSA':
        final keyPairHandle = _keyPairHandles[map['key_pair_handle']]!;
        return AdditionalConfig.storageConfigDsa(keyPairHandle);
      case 'StorageConfigPass':
        return AdditionalConfig.storageConfigPass(map['pass']);
      default:
        throw TsDartBridgeException('Unknown additional config type', map['type']);
    }
  }

  Map<String, dynamic> encodeAdditionalConfig(AdditionalConfig config) {
    switch (config) {
      case AdditionalConfig_FileStoreConfig(:final dbDir):
        return {
          'type': 'FileStoreConfig',
          'db_dir': dbDir,
        };
      case AdditionalConfig_StorageConfigHMAC(:final field0):
        return {
          'type': 'StorageConfigHMAC',
          'key_handle': field0,
        };
      case AdditionalConfig_StorageConfigDSA(:final field0):
        return {
          'type': 'StorageConfigDSA',
          'key_pair_handle': field0,
        };
      case AdditionalConfig_StorageConfigPass(:final field0):
        return {
          'type': 'StorageConfigPass',
          'pass': field0,
        };
      default:
        throw TsDartBridgeException('Unknown additional config type', config.runtimeType.toString());
    }
  }

  KeySpec decodeKeySpec(Map<String, dynamic> map) {
    final cipher = decodeCipher(map['cipher']);
    final signingHash = decodeCryptoHash(map['signing_hash']);
    return KeySpec(cipher: cipher, signingHash: signingHash, ephemeral: map['ephemeral']);
  }

  Map<String, dynamic> encodeKeySpec(KeySpec spec) {
    return {
      'cipher': encodeCipher(spec.cipher),
      'signing_hash': encodeCryptoHash(spec.signingHash),
      'ephemeral': spec.ephemeral,
    };
  }

  KeyPairSpec decodeKeyPairSpec(Map<String, dynamic> map) {
    final asymSpec = decodeAsymmetricKeySpec(map['asym_spec']);
    final cipher = map['cipher'] == null ? null : decodeCipher(map['cipher']);
    final signingHash = decodeCryptoHash(map['signing_hash']);
    return KeyPairSpec(
        asymSpec: asymSpec, cipher: cipher, signingHash: signingHash, ephemeral: map['ephemeral'], nonExportable: map['non_exportable']);
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
}
