import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter_test/flutter_test.dart';

void run(EnmeshedRuntime runtime, ConnectorClient connector) async {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // // dummy application to have all the required plugins available
  // dummyApp.main();

  testWidgets(
    'start runtime and check that it is ready and make first communication with the connector',
    (tester) async {
      // final completer = Completer();
      // final runtime = EnmeshedRuntime(completer.complete);
      // await runtime.run();
      // await completer.future;

      // expect(runtime.isReady, true);
      // final connector = ConnectorClient('https://enmeshed-on-bird.is.enmeshed.eu', 'jCtDEqvQd6NT1iHFQ8C00Yg6LBlRuYvZ');
      final template = await connector.relationshipTemplates.createOwnRelationshipTemplate(expiresAt: '2024', content: {'foo': 'bar'});
      final templateInTheApp = await runtime.currentSession.transportServices.relationshipTemplates
          .loadPeerRelationshipTemplateByReference(reference: template.data.truncatedReference);

      expect(template.data.content, templateInTheApp.content);
    },
  );
}
