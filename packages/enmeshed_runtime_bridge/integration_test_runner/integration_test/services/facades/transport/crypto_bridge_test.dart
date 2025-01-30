import 'dart:typed_data';

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
      expect(providers, isNotEmpty);
    });

    test('should create Provider from name SoftwareProvider', () async {
      final cal.ProviderImplConfig implConfig = cal.ProviderImplConfig(additionalConfig: [cal.AdditionalConfig.storageConfigPass('test')]);
      final provider = await CryptoFacade(evaluator).createProviderFromName('SoftwareProvider', implConfig);
      expect(provider, isNotNull);
    });

    test('sign and verify data with SoftwareProvider', () async {
      final cal.ProviderImplConfig implConfig = cal.ProviderImplConfig(additionalConfig: [cal.AdditionalConfig.storageConfigPass('test')]);
      final facade = CryptoFacade(evaluator);
      final provider = await facade.createProviderFromName('SoftwareProvider', implConfig);
      final caps = await provider.getCapabilities();
      for (final aspec in caps.supportedAsymSpec) {
        final spec = cal.KeyPairSpec(signingHash: cal.CryptoHash.sha2256, ephemeral: true, asymSpec: aspec, nonExportable: false);
        final keyPair = await provider.crateKeyPair(spec);
        expect(keyPair, isNotNull);
        final data = Uint8List.fromList('test'.codeUnits);
        final signature = await keyPair.sign(data);
        final verified = await keyPair.verify(data, signature);
        expect(verified, isTrue);
      }
    });
  });
}
