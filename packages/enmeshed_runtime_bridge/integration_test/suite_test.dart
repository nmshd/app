import 'dart:async';

import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:integration_test/integration_test.dart';

import './enmeshed_runtime_bridge1.dart' as bridge_test;
import './enmeshed_runtime_bridge2.dart' as bridge_test2;
import 'dummy_app.dart' as dummyApp;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // dummy application to have all the required plugins available
  dummyApp.main();

  Completer completer;
  EnmeshedRuntime runtime;
  ConnectorClient connector;

  completer = Completer();
  runtime = EnmeshedRuntime(completer.complete);
  await runtime.run();
  await completer.future;
  connector = ConnectorClient(const String.fromEnvironment('connector_baseURL'), const String.fromEnvironment('connector_apiKey'));

  bridge_test.run(runtime, connector);
  bridge_test2.run(runtime, connector);
}
