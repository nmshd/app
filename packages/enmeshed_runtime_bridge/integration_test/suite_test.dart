import 'dart:async';

import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:integration_test/integration_test.dart';

import './src/services/facades/relationship_template_facade_test.dart' as relationship_template_facade_test;
import 'dummy_app.dart' as dummyApp;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  dummyApp.main();

  Completer completer;
  EnmeshedRuntime runtime;
  ConnectorClient connector;

  completer = Completer();
  runtime = EnmeshedRuntime(completer.complete);
  await runtime.run();
  await completer.future;
  connector = ConnectorClient(const String.fromEnvironment('connector_baseURL'), const String.fromEnvironment('connector_apiKey'));

  relationship_template_facade_test.run(runtime, connector);
}
