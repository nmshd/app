@Timeout(Duration(minutes: 1))

import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

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

  print('#################################################################');
  print('#################################################################');
  print('#################################################################');
  print('#################################################################');

  final connectorClient = ConnectorClient(const String.fromEnvironment('connector_baseURL'), const String.fromEnvironment('connector_apiKey'));

  relationship_template_facade_test.run(runtime, connectorClient);
  relationships_facade_test.run(runtime, connectorClient);
  files_facade_test.run(runtime);
}
