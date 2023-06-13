import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers.dart';
import '../../utils.dart';

void run(EnmeshedRuntime runtime) {
  late LocalAccountDTO account;
  late Session session;

  setUpAll(() async {
    account = await runtime.accountServices.createAccount(name: 'attributesFacade Test');
    session = runtime.getSession(account.id);
  });

  group('AccountFacade: getIdentityInfo', () {
    testWidgets('returns a valid GetIdentityInfoResponse', (_) async {
      final identityInfoResult = await session.transportServices.account.getIdentityInfo();
      final identityInfo = identityInfoResult.value;

      expect(identityInfoResult, isSuccessful<GetIdentityInfoResponse>());
      expect(identityInfo.address.length, lessThanOrEqualTo(36));
      expect(identityInfo.address.length, greaterThanOrEqualTo(35));
      expect(identityInfo.address, contains('id1'));
      expect(identityInfo.publicKey.length, equals(82));
    });
  });

  group('AccountFacade: getDeviceInfo', () {
    testWidgets('returns a valid DeviceDTO', (_) async {
      final deviceInfoResult = await session.transportServices.account.getDeviceInfo();

      expect(deviceInfoResult, isSuccessful<DeviceDTO>());
    });
  });

  group('AccountFacade: syncDatawallet', () {
    Future<SyncInfoResponse> getSyncInfo(_) async {
      final sync = await session.transportServices.account.getSyncInfo();
      return sync.value;
    }

    testWidgets('runs an automatic datawallet sync', (_) async {
      await session.transportServices.account.syncDatawallet();
      final oldSyncTime = await getSyncInfo();

      await uploadFile(session);
      final newSyncTime = await getSyncInfo();

      expect(oldSyncTime, isNot(newSyncTime));
    });

    testWidgets('runs not an automatic datawallet sync', (_) async {
      await session.transportServices.account.disableAutoSync();

      await session.transportServices.account.syncDatawallet();
      final oldSyncTime = await getSyncInfo();

      await uploadFile(session);
      expect(await getSyncInfo(), oldSyncTime);

      await session.transportServices.account.enableAutoSync();

      expect(await getSyncInfo(), isNot(oldSyncTime));
    });
  });

  group('AccountFacade: syncEverything', () {
    testWidgets('returns a valid SyncEverythingResponse', (_) async {
      final syncResult = await session.transportServices.account.syncEverything();

      expect(syncResult, isSuccessful<SyncEverythingResponse>());
    });

    testWidgets('returns the same future when calling syncEverything twice without awaiting', (_) async {
      final syncResults = await Future.wait([
        session.transportServices.account.syncEverything(),
        session.transportServices.account.syncEverything(),
      ]);

      final sync1 = syncResults[0].value;
      final sync2 = syncResults[1].value;

      expect(sync1, sync2);
    });
  });

  group('AccountFacade: getSyncInfo', () {
    testWidgets('returns a valid SyncInfoResponse', (_) async {
      final syncResult = await session.transportServices.account.getSyncInfo();

      expect(syncResult, isSuccessful<SyncInfoResponse>());
    });
  });

  group('AccountFacade: LoadItemFromTruncatedReference', () {
    group('File', () {
      String fileReference = '';
      String fileTokenReference = '';

      setUpAll(() async {
        final file = await uploadFile(session);
        fileReference = file.truncatedReference;
        fileTokenReference = (await session.transportServices.files.createTokenForFile(fileId: file.id)).value.truncatedReference;
      });

      testWidgets('loads the File with the truncated reference', (_) async {
        final result = await session.transportServices.account.loadItemFromTruncatedReference(reference: fileReference);

        expect(result.value.type, LoadItemFromTruncatedReferenceResponseType.File);
      });

      testWidgets('loads the File with the truncated Token reference', (_) async {
        final result = await session.transportServices.account.loadItemFromTruncatedReference(reference: fileTokenReference);

        expect(result.value.type, LoadItemFromTruncatedReferenceResponseType.File);
      });
    });

    group('RelationshipTemplate', () {
      String relationshipTemplateReference = '';
      String relationshipTemplateTokenReference = '';

      setUpAll(() async {
        final relationshipTemplate =
            (await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(expiresAt: generateExpiryString(), content: {}))
                .value;
        relationshipTemplateReference = relationshipTemplate.truncatedReference;
        relationshipTemplateTokenReference =
            (await session.transportServices.relationshipTemplates.createTokenForOwnTemplate(templateId: relationshipTemplate.id))
                .value
                .truncatedReference;
      });

      testWidgets('loads the RelationshipTemplate with the truncated reference', (_) async {
        final result = await session.transportServices.account.loadItemFromTruncatedReference(reference: relationshipTemplateReference);

        expect(result.value.type, LoadItemFromTruncatedReferenceResponseType.RelationshipTemplate);
      });

      testWidgets('loads the RelationshipTemplate with the truncated Token reference', (_) async {
        final result = await session.transportServices.account.loadItemFromTruncatedReference(reference: relationshipTemplateTokenReference);

        expect(result.value.type, LoadItemFromTruncatedReferenceResponseType.RelationshipTemplate);
      });
    });

    //TODO: add test for Token
    //TODO: add test for DeviceOnboardingInfo
  });
}
