import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';
import 'setup.dart';
import 'utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime enmeshedRuntime) {
  group('[StringProcessor]', () {
    final uiBridge = FakeUIBridge();

    // the UI Bridge is called in the StringProcessor, so we need to register it
    setUpAll(() async => enmeshedRuntime.registerUIBridge(uiBridge));
    setUp(() => uiBridge.reset());

    group('processURL', () {
      test('should handle an invalid URL', () async {
        final result = await enmeshedRuntime.stringProcessor.processURL(url: 'https://qr#invalid');
        expect(result, isFailing('error.appruntime.startup.WrongURL'));
      });

      test('should handle an invalid truncated reference in the URL', () async {
        final result = await enmeshedRuntime.stringProcessor.processURL(url: 'nmshd://qr#invalid').timeout(const Duration(seconds: 20));
        expect(result, isFailing('error.appruntime.startup.WrongCode'));
      });
    });

    group('processTruncatedReference', () {
      test('should handle an invalid truncated reference', () async {
        final result = await enmeshedRuntime.stringProcessor.processTruncatedReference(truncatedReference: 'invalid');
        expect(result, isFailing('error.appruntime.startup.WrongCode'));
      });
    });
  });
}
