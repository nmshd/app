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
    test('returns a valid GetIdentityInfoResponse', () async {
      final identityInfoResult = await session.transportServices.accounts.getIdentityInfo();
      final identityInfo = identityInfoResult.value;

      expect(identityInfoResult, isSuccessful<GetIdentityInfoResponse>());
      expect(identityInfo.address.length, lessThanOrEqualTo(36));
      expect(identityInfo.address.length, greaterThanOrEqualTo(35));
      expect(identityInfo.address, contains('id1'));
      expect(identityInfo.publicKey.length, equals(82));
    });
  });

  group('AccountFacade: getDeviceInfo', () {
    test('returns a valid DeviceDTO', () async {
      final deviceInfoResult = await session.transportServices.accounts.getDeviceInfo();

      expect(deviceInfoResult, isSuccessful<DeviceDTO>());
    });
  });

  group('AccountFacade: syncDatawallet', () {
    Future<SyncInfoResponse> getSyncInfo() async {
      final sync = await session.transportServices.accounts.getSyncInfo();
      return sync.value;
    }

    test('runs an automatic datawallet sync', () async {
      await session.transportServices.accounts.syncDatawallet();
      final oldSyncTime = await getSyncInfo();

      await uploadFile(session);
      final newSyncTime = await getSyncInfo();

      expect(oldSyncTime, isNot(newSyncTime));
    });

    test('runs not an automatic datawallet sync', () async {
      await session.transportServices.accounts.disableAutoSync();

      await session.transportServices.accounts.syncDatawallet();
      final oldSyncTime = await getSyncInfo();

      await uploadFile(session);
      expect(await getSyncInfo(), oldSyncTime);

      await session.transportServices.accounts.enableAutoSync();

      expect(await getSyncInfo(), isNot(oldSyncTime));
    });
  });

  group('AccountFacade: syncEverything', () {
    test('returns a valid SyncEverythingResponse', () async {
      final syncResult = await session.transportServices.accounts.syncEverything();

      expect(syncResult, isSuccessful<SyncEverythingResponse>());
    });

    test('returns the same future when calling syncEverything twice without awaiting', () async {
      final syncResults = await Future.wait([
        session.transportServices.accounts.syncEverything(),
        session.transportServices.accounts.syncEverything(),
      ]);

      final sync1 = syncResults[0].value;
      final sync2 = syncResults[1].value;

      expect(sync1, sync2);
    });
  });

  group('AccountFacade: getSyncInfo', () {
    test('returns a valid SyncInfoResponse', () async {
      final syncResult = await session.transportServices.accounts.getSyncInfo();

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

      test('loads the File with the truncated reference', () async {
        final result = await session.transportServices.accounts.loadItemFromTruncatedReference(reference: fileReference);

        expect(result.value.type, LoadItemFromTruncatedReferenceResponseType.File);
      });

      test('loads the File with the truncated Token reference', () async {
        final result = await session.transportServices.accounts.loadItemFromTruncatedReference(reference: fileTokenReference);

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

      test('loads the RelationshipTemplate with the truncated reference', () async {
        final result = await session.transportServices.accounts.loadItemFromTruncatedReference(reference: relationshipTemplateReference);

        expect(result.value.type, LoadItemFromTruncatedReferenceResponseType.RelationshipTemplate);
      });

      test('loads the RelationshipTemplate with the truncated Token reference', () async {
        final result = await session.transportServices.accounts.loadItemFromTruncatedReference(reference: relationshipTemplateTokenReference);

        expect(result.value.type, LoadItemFromTruncatedReferenceResponseType.RelationshipTemplate);
      });
    });

    //TODO: add test for Token
    //TODO: add test for DeviceOnboardingInfo
  });
}
