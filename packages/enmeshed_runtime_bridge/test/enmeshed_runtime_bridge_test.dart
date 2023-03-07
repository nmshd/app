import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('runtime is not ready', () {
    WidgetsFlutterBinding.ensureInitialized();
    final runtime = EnmeshedRuntime(runtimeReadyCallback: () {});
    expect(runtime.isReady, false);
  });
}
