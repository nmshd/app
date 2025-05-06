import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late Session session;

  setUpAll(() async {
    final account = await runtime.accountServices.createAccount(name: 'filesFacade Test');
    session = runtime.getSession(account.id);
  });

  group('[PublicRelationshipTemplateReferencesFacade] getPublicRelationshipTemplateReferences', () {
    test('should get the PublicRelationshipTemplateReferences', () async {
      final referencesResult = await session.transportServices.publicRelationshipTemplateReferences.getPublicRelationshipTemplateReferences();

      expect(referencesResult, isSuccessful<List<PublicRelationshipTemplateReferenceDTO>>());
    });
  });
}
