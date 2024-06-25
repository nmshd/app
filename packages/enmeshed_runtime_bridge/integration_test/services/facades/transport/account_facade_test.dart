import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_runtime_bridge/src/services/facades/transport/account_facade.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';
import '../../../utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late LocalAccountDTO account;
  late Session session;

  setUpAll(() async {
    account = await runtime.accountServices.createAccount(name: 'accountFacade Test');
    session = runtime.getSession(account.id);
  });

  group('AccountFacade: getIdentityInfo', () {
    test('should return identity information', () async {
      final identityInfoResult = await session.transportServices.account.getIdentityInfo();

      expect(identityInfoResult, isSuccessful<GetIdentityInfoResponse>());
      expect(identityInfoResult.value.address.length, lessThanOrEqualTo(36));
      expect(identityInfoResult.value.address.length, greaterThanOrEqualTo(35));
      expect(identityInfoResult.value.address, contains('id1'));
      expect(identityInfoResult.value.publicKey.length, equals(82));
    });
  });

  group('AccountFacade: getDeviceInfo', () {
    test('should return device information', () async {
      final deviceInfoResult = await session.transportServices.account.getDeviceInfo();

      expect(deviceInfoResult, isSuccessful<DeviceDTO>());
    });
  });

  group('AccountFacade: syncDatawallet', () {
    Future<SyncInfoResponse> getSyncInfo() async {
      final sync = await session.transportServices.account.getSyncInfo();
      return sync.value;
    }

    test('should run an automatic datawallet sync', () async {
      await session.transportServices.account.syncDatawallet();
      final oldSyncTime = await getSyncInfo();

      await uploadFile(session);
      final newSyncTime = await getSyncInfo();

      expect(oldSyncTime, isNot(newSyncTime));
    });

    test('should run not an automatic datawallet sync', () async {
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
    test('should return a valid SyncEverythingResponse', () async {
      final syncResult = await session.transportServices.account.syncEverything();

      expect(syncResult, isSuccessful<SyncEverythingResponse>());
    });

    test('should return the same future when calling syncEverything twice without awaiting', () async {
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
    test('should return a valid SyncInfoResponse', () async {
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

      test('should load the File with the truncated reference', () async {
        final result = await session.transportServices.account.loadItemFromTruncatedReference(reference: fileReference);

        expect(result, isSuccessful<LoadItemFromTruncatedReferenceResponse>());
        expect(result.value.type, LoadItemFromTruncatedReferenceResponseType.File);
      });

      test('should load the File with the truncated Token reference', () async {
        final result = await session.transportServices.account.loadItemFromTruncatedReference(reference: fileTokenReference);

        expect(result, isSuccessful<LoadItemFromTruncatedReferenceResponse>());
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

      test('should load the RelationshipTemplate with the truncated reference', () async {
        final result = await session.transportServices.account.loadItemFromTruncatedReference(reference: relationshipTemplateReference);

        expect(result, isSuccessful<LoadItemFromTruncatedReferenceResponse>());
        expect(result.value.type, LoadItemFromTruncatedReferenceResponseType.RelationshipTemplate);
      });

      test('should load the RelationshipTemplate with the truncated Token reference', () async {
        final result = await session.transportServices.account.loadItemFromTruncatedReference(reference: relationshipTemplateTokenReference);

        expect(result, isSuccessful<LoadItemFromTruncatedReferenceResponse>());
        expect(result.value.type, LoadItemFromTruncatedReferenceResponseType.RelationshipTemplate);
      });
    });

    //TODO: add test for Token
    //TODO: add test for DeviceOnboardingInfo
  });

  group('Un-/RegisterPushNotificationToken', () {
    test('register push notification token with production environment', () async {
      final result = await session.transportServices.account.registerPushNotificationToken(
          handle: 'handleLongerThan10Characters',
          platform: 'dummy',
          appId: 'appId',
          environment: AccountFacadePushNotificationEnvironment.production);

      expect(result, isSuccessful<RegisterPushNotificationTokenResponse>());
      final matcher = RegExp(r'^DPI[a-zA-Z0-9]{17}$');
      expect(matcher.hasMatch(result.value.devicePushIdentifier), true);
    });

    test('register push notification token with development environment', () async {
      final result = await session.transportServices.account.registerPushNotificationToken(
          handle: 'handleLongerThan10Characters',
          platform: 'dummy',
          appId: 'appId',
          environment: AccountFacadePushNotificationEnvironment.development);

      expect(result, isSuccessful<RegisterPushNotificationTokenResponse>());
      final matcher = RegExp(r'^DPI[a-zA-Z0-9]{17}$');
      expect(matcher.hasMatch(result.value.devicePushIdentifier), true);
    });

    test('unregister push notification token', () async {
      final result = await session.transportServices.account.unregisterPushNotificationToken();

      expect(result, isSuccessful());
    });
  });
}
