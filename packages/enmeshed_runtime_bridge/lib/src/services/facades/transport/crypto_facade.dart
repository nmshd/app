import 'dart:convert';
import 'dart:typed_data';

import 'package:cal_flutter_plugin/cal_flutter_plugin.dart' as cal;
import 'package:enmeshed_runtime_bridge/src/crypto_bridge.dart';

import '../abstract_evaluator.dart';

class CryptoFacadeException implements Exception {
  final String message;
  CryptoFacadeException(this.message);

  @override
  String toString() {
    return 'CryptoFacadeException: $message';
  }
}

class CryptoFacade {
  final AbstractEvaluator _evaluator;
  final CryptoHandler _handler = CryptoHandler();
  CryptoFacade(this._evaluator);

  Future<CryptoFacadeProvider> createProvider(cal.ProviderConfig config, cal.ProviderImplConfig implConfig) async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const provider = await window.cryptoInit.createProvider(config, implConfig)
      if (provider) return provider._id;
      return null;
    ''',
      arguments: {
        'config': jsonEncode(_handler.encodeProviderConfig(config)),
        'implConfig': jsonEncode(_handler.encodeProviderImplConfig(implConfig)),
      },
    );
    if (result.toMap()['value'] == null) {
      throw CryptoFacadeException(result.toMap()['error'].toString());
    }
    final id = result.toMap()['value'].toString();
    return CryptoFacadeProvider(_evaluator, id, _handler);
  }

  Future<CryptoFacadeProvider> createProviderFromName(String name, cal.ProviderImplConfig implConfig) async {
    final mapImplConfig = _handler.encodeProviderImplConfig(implConfig);

    final result = await _evaluator.evaluateJavaScript(
      '''
      const provider = await window.cryptoInit.createProviderFromName(name, implConfig)
      if (provider) return provider._id;
      return null;
    ''',
      arguments: {'name': name, 'implConfig': mapImplConfig},
    );
    if (result.toMap()['value'] == null) {
      throw CryptoFacadeException(result.toMap()['error'].toString());
    }
    final id = result.toMap()['value'].toString();
    return CryptoFacadeProvider(_evaluator, id, _handler);
  }

  Future<List<String>> getAllProviders() async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const providers = await window.cryptoInit.getAllProviders()
      if (providers) return providers;
      return [];
    ''',
    );
    if (result.toMap()['value'] == null) {
      throw CryptoFacadeException(result.toMap()['error'].toString());
    }
    return result.toMap()['value'].cast<String>();
  }

  Future<List<(String, cal.ProviderConfig)>> getProviderCapabilities(cal.ProviderImplConfig implConfig) async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const providers = await window.cryptoInit.getProviderCapabilities(implConfig)
      return providers;
    ''',
      arguments: {'implConfig': _handler.encodeProviderImplConfig(implConfig)},
    );
    if (result.toMap()['value'] == null) {
      throw CryptoFacadeException(result.toMap()['error'].toString());
    }
    final List<dynamic> list = result.toMap()['value'];
    return list.map((e) {
      final id = e[0].toString();
      final config = _handler.decodeProviderConfig(e[1]);
      return (id, config);
    }).toList();
  }
}

class CryptoFacadeProvider {
  final AbstractEvaluator _evaluator;
  final String _id;
  final CryptoHandler _handler;
  CryptoFacadeProvider(this._evaluator, this._id, this._handler);

  CryptoFacade get crypto => CryptoFacade(_evaluator);

  Future<cal.ProviderConfig> getCapabilities() async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const provider = window.cryptoInit.provider();
      provider._id = id;
      const capabilities = await provider.getCapabilities();
      return capabilities;
    ''',
      arguments: {'id': _id},
    );
    if (result.toMap()['value'] == null) {
      throw CryptoFacadeException(result.toMap()['error'].toString());
    }
    return _handler.decodeProviderConfig(result.toMap()['value']);
  }

  Future<CryptoFacadeKeyPairHandle> crateKeyPair(cal.KeyPairSpec spec) async {
    final Map<String, dynamic> mapSpec = _handler.encodeKeyPairSpec(spec);

    final result = await _evaluator.evaluateJavaScript(
      '''
      const provider = window.cryptoInit.provider();
      provider._id = id;
      const key = await provider.createKeyPair(spec);
      if (key) {
        return key._id;
      }
      return null;
    ''',
      arguments: {'id': _id, 'spec': mapSpec},
    );
    if (result.toMap()['value'] == null) {
      throw CryptoFacadeException(result.toMap()['error'].toString());
    }
    final id = result.toMap()['value'].toString();
    return CryptoFacadeKeyPairHandle(_evaluator, id, _handler);
  }

  Future<String> crateKey(cal.KeyPairSpec spec) async {
    final Map<String, dynamic> mapSpec = _handler.encodeKeyPairSpec(spec);

    final result = await _evaluator.evaluateJavaScript(
      '''
      const provider = window.cryptoInit.provider();
      provider._id = id;
      const key = await provider.createKey(spec);
      if (key) {
        return key._id;
      }
      return null;
    ''',
      arguments: {'id': _id, 'spec': mapSpec},
    );
    if (result.toMap()['value'] == null) {
      throw CryptoFacadeException(result.toMap()['error'].toString());
    }
    return result.toMap()['value'].toString();
  }
}

class CryptoFacadeKeyPairHandle {
  final AbstractEvaluator _evaluator;
  final String _id;
  final CryptoHandler _handler;
  CryptoFacadeKeyPairHandle(this._evaluator, this._id, this._handler);

  Future<Uint8List> sign(Uint8List data) async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const key = window.cryptoInit.keyPairHandle(id);
      const signature = await key.signData(data);
      return signature;
    ''',
      arguments: {'id': _id, 'data': data},
    );
    if (result.toMap()['value'] == null) {
      throw CryptoFacadeException(result.toMap()['error'].toString());
    }
    final sig = Uint8List.fromList(result.toMap()['value'].values.toList().cast<int>());
    return sig;
  }

  Future<bool> verify(Uint8List data, Uint8List signature) async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const key = window.cryptoInit.keyPairHandle(id);
      const verified = key.verifySignature(data, signature);
      return verified;
    ''',
      arguments: {'id': _id, 'data': data, 'signature': signature},
    );
    if (result.toMap()['value'] == null) {
      throw CryptoFacadeException(result.toMap()['error'].toString());
    }
    return result.toMap()['value'];
  }
}
