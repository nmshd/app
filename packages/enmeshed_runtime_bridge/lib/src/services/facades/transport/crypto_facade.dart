import 'dart:convert';

import 'package:cal_flutter_plugin/cal_flutter_plugin.dart' as cal;
import 'package:enmeshed_runtime_bridge/src/crypto_bridge.dart';

import '../abstract_evaluator.dart';

class CryptoFacade {
  final AbstractEvaluator _evaluator;
  final CryptoHandler _handler = CryptoHandler();
  CryptoFacade(this._evaluator);

  Future<CryptoFacadeProvider> createProvider(
      cal.ProviderConfig config, cal.ProviderImplConfig implConfig) async {
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
    final id = result.toString();
    return CryptoFacadeProvider(_evaluator, id);
  }

  Future<CryptoFacadeProvider> createProviderFromName(
      String name, cal.ProviderImplConfig implConfig) async {
    Map<String, dynamic> mapImplConfig =
        _handler.encodeProviderImplConfig(implConfig);
    String encodedImplConfig = jsonEncode(mapImplConfig);

    final result = await _evaluator.evaluateJavaScript(
      '''
      const provider = await window.cryptoInit.createProviderFromName(name, implConfig)
      if (provider) return provider._id;
      return null;
    ''',
      arguments: {'name': name, 'implConfig': mapImplConfig},
    );
    final id = result.toString();
    return CryptoFacadeProvider(_evaluator, id);
  }

  Future<List<String>> getAllProviders() async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const providers = await window.cryptoInit.getAllProviders()
      if (providers) return providers;
      return [];
    ''',
    );
    return result.toMap()['value'].cast<String>();
  }
}

class CryptoFacadeProvider {
  final AbstractEvaluator _evaluator;
  final String _id;
  CryptoFacadeProvider(this._evaluator, this._id);

  CryptoFacade get crypto => CryptoFacade(_evaluator);

  Future<String> signData(String data) async {
    final result = await _evaluator.evaluateJavaScript(
      '''
      const signature = await window.cryptoInit.signData(id, data)
      if (signature) return signature;
      return null;
    ''',
      arguments: {'id': _id, 'data': data},
    );
    return result.toString();
  }
}
