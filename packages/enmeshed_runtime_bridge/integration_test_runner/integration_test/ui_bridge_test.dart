import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter_test/flutter_test.dart';

import 'setup.dart';
import 'utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime enmeshedRuntime) {
  final uiBridge = FakeUIBridge();

  setUpAll(() async {
    enmeshedRuntime.registerUIBridge(uiBridge);
  });
}
