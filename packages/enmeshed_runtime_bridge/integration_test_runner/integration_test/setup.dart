import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logger/logger.dart';

import 'dummy_app.dart' as dummy_app;
import 'mock_event_bus.dart';

Future<EnmeshedRuntime> setup() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  dummy_app.main();

  EnmeshedRuntime.setAssetsFolder('assets');
  final eventBus = MockEventBus();
  // reset event bus before each test to get rid of old events
  setUp(() => eventBus.reset());

  final runtime = EnmeshedRuntime(
    runtimeConfig: (
      baseUrl: const String.fromEnvironment('app_baseUrl'),
      clientId: const String.fromEnvironment('app_clientId'),
      clientSecret: const String.fromEnvironment('app_clientSecret'),
      applicationId: 'eu.enmeshed.test',
      useAppleSandbox: const bool.fromEnvironment('app_useAppleSandbox'),
      databaseFolder: './database',
    ),
    logger: Logger(printer: SimplePrinter(colors: false), level: Level.warning),
    eventBus: eventBus,
  );
  await runtime.run();

  return runtime;
}
