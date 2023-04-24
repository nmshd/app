import 'dart:async';

import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'dummy_app.dart' as dummyApp;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // dummy application to have all the required plugins available
  dummyApp.main();

  testWidgets(
    'start runtime and check that it is ready and make first communication with the connector',
    (tester) async {
      final completer = Completer();
      final runtime = EnmeshedRuntime(completer.complete);
      await runtime.run();
      await completer.future;

      expect(runtime.isReady, true);
      final template = await connector.relationshipTemplates.createOwnRelationshipTemplate(expiresAt: '2024', content: {'foo': 'bar'});
      final templateInTheApp = await runtime.currentSession.transportServices.relationshipTemplates
          .loadPeerRelationshipTemplateByReference(reference: template.data.truncatedReference);

      expect(template.data.content, templateInTheApp.content);
    },
  );
}
