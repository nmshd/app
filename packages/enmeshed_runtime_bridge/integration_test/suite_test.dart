import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'services/facades/account_facade_test.dart' as account_facade_test;
import 'services/facades/attributes_facade_test.dart' as attributes_facade_test;
import 'services/facades/files_facade_test.dart' as files_facade_test;
import 'services/facades/relationship_template_facade_test.dart' as relationship_template_facade_test;
import 'services/facades/relationships_facade_test.dart' as relationships_facade_test;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  EnmeshedRuntime.setAssetsFolder('assets');
  final runtime = EnmeshedRuntime();

  setUpAll(() async {
    runApp(const MaterialApp(home: Text('Dummy App')));
    await runtime.run();
  });

  final connectorClient = ConnectorClient(const String.fromEnvironment('connector_baseURL'), const String.fromEnvironment('connector_apiKey'));

  relationship_template_facade_test.run(runtime, connectorClient);
  relationships_facade_test.run(runtime, connectorClient);
  files_facade_test.run(runtime);
  attributes_facade_test.run(runtime);
  account_facade_test.run(runtime);
}
