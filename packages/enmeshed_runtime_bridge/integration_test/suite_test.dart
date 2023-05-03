import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:integration_test/integration_test.dart';

import './src/services/facades/relationship_template_facade_test.dart' as relationship_template_facade_test;
import 'dummy_app.dart' as dummy_app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  dummy_app.main();

  EnmeshedRuntime.setAssetsFolder('assets');
  final runtime = EnmeshedRuntime();

  await runtime.run();
  final connectorClient = ConnectorClient(const String.fromEnvironment('connector_baseURL'), const String.fromEnvironment('connector_apiKey'));

  relationship_template_facade_test.run(runtime, connectorClient);
}
