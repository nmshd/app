import 'package:cal_flutter_plugin/cal_flutter_plugin.dart' as cal;
import 'package:enmeshed_runtime_bridge/src/enmeshed_runtime.dart';
import 'package:enmeshed_runtime_bridge/src/services/facades/transport/crypto_facade.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../setup.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late Evaluator evaluator;

  setUpAll(() async {
    evaluator = Evaluator.anonymous(runtime);
  });

  group('CryptoFacade', () {
    test('should find provider names', () async {
      final providers = await CryptoFacade(evaluator).getAllProviders();
      print(providers);
      expect(providers, isNotEmpty);
    });

    test('should create Provider from name SoftwareProvider', () async {
      final cal.ProviderImplConfig implConfig = cal.ProviderImplConfig(
          additionalConfig: [cal.AdditionalConfig.storageConfigPass('test')]);
      final provider = await CryptoFacade(evaluator)
          .createProviderFromName('SoftwareProvider', implConfig);
      expect(provider, isNotNull);
    });

    test('sign data with every provider', () async {
      final cal.ProviderImplConfig implConfig = cal.ProviderImplConfig(
          additionalConfig: [cal.AdditionalConfig.storageConfigPass('test')]);
      final providers = await CryptoFacade(evaluator).getAllProviders();
      for (final providerName in providers) {
        final facade = CryptoFacade(evaluator);
        final provider =
            await facade.createProviderFromName(providerName, implConfig);
        final signature = await provider.signData('test');
        expect(signature, isNotNull);
      }
    });
  });
}
