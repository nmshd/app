import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter_test/flutter_test.dart';

import 'setup.dart';
import 'utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime enmeshedRuntime) {
  final uiBridge = FakeUIBridge();

  group('[UIBridge]', () {
    test('successfully registering the UI Bridge', () async {
      expect(enmeshedRuntime.registerUIBridge(uiBridge), completes);
    });
  });
}
