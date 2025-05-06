import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../mock_event_bus.dart';
import '../../../setup.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late LocalAccountDTO account;
  late Session session;
  late MockEventBus eventBus;

  setUpAll(() async {
    account = await runtime.accountServices.createAccount(name: 'identityDeletionProcessesFacade Test');
    session = runtime.getSession(account.id);

    eventBus = runtime.eventBus as MockEventBus;
  });

  setUp(() async {
    eventBus.reset();
  });

  tearDown(() async {
    final activeIdentityDeletionProcess = await session.transportServices.identityDeletionProcesses.getActiveIdentityDeletionProcess();
    if (!activeIdentityDeletionProcess.isSuccess) {
      return;
    }
    Result abortResult;
    if (activeIdentityDeletionProcess.value.status == IdentityDeletionProcessStatus.Approved) {
      abortResult = await session.transportServices.identityDeletionProcesses.cancelIdentityDeletionProcess();
      if (abortResult.isError) throw abortResult.error;
    } else if (activeIdentityDeletionProcess.value.status == IdentityDeletionProcessStatus.WaitingForApproval) {
      abortResult = await session.transportServices.identityDeletionProcesses.rejectIdentityDeletionProcess();
      if (abortResult.isError) throw abortResult.error;
    }
    return;
  });

  group('Initiate IdentityDeletionProcess', () {
    test('should initiate an IdentityDeletionProcess', () async {
      final result = await session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();
      expect(result, isSuccessful<IdentityDeletionProcessDTO>());

      final identityDeletionProcess = result.value;
      expect(identityDeletionProcess.status, IdentityDeletionProcessStatus.Approved);

      final event = await eventBus.waitForEvent<IdentityDeletionProcessStatusChangedEvent>(eventTargetAddress: account.address!);
      expect(event.data.id, identityDeletionProcess.id);
      expect(event.data.status, IdentityDeletionProcessStatus.Approved);
    });

    test('should return an error trying to initiate an IdentityDeletionProcess if there already is one', () async {
      final result1 = await session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();
      expect(result1, isSuccessful<IdentityDeletionProcessDTO>());

      final result2 = await session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();
      expect(result2, isFailing('error.runtime.identityDeletionProcess.activeIdentityDeletionProcessAlreadyExists'));
    });
  });

  group('Get active IdentityDeletionProcess', () {
    test('should get the active IdentityDeletionProcess', () async {
      final initiateResult = await session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();
      final initiatedIdentityDeletionProcess = initiateResult.value;

      final result = await session.transportServices.identityDeletionProcesses.getActiveIdentityDeletionProcess();
      expect(result, isSuccessful<IdentityDeletionProcessDTO>());

      final identityDeletionProcess = result.value;
      expect(identityDeletionProcess, initiatedIdentityDeletionProcess);
    });

    test('should return an error trying to get the active IdentityDeletionProcess if there is none active', () async {
      final result = await session.transportServices.identityDeletionProcesses.getActiveIdentityDeletionProcess();
      expect(result, isFailing('error.runtime.identityDeletionProcess.noActiveIdentityDeletionProcess'));
    });
  });

  group('Get IdentityDeletionProcess', () {
    test('should get an IdentityDeletionProcess specifying an ID', () async {
      final initiateResult = await session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();
      final initiatedIdentityDeletionProcess = initiateResult.value;

      final result = await session.transportServices.identityDeletionProcesses.getIdentityDeletionProcess(initiatedIdentityDeletionProcess.id);
      expect(result, isSuccessful<IdentityDeletionProcessDTO>());

      final identityDeletionProcess = result.value;
      expect(identityDeletionProcess, initiatedIdentityDeletionProcess);
    });

    test('should return an error trying to get an IdentityDeletionProcess specifying an unknown ID', () async {
      final result = await session.transportServices.identityDeletionProcesses.getIdentityDeletionProcess('IDPxxxxxxxxxxxxxxxxx');
      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('Get IdentityDeletionProcesses', () {
    test('should get all IdentityDeletionProcesses', () async {
      // Initialize new Identities for these tests as otherwise they would be depending on the other tests
      await runtime.accountServices.offboardAccount(account.id);
      account = await runtime.accountServices.createAccount(name: 'identityDeletionProcessesFacade Test');
      session = runtime.getSession(account.id);

      final cancelledIdentityDeletionProcess = (await session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess()).value;
      await session.transportServices.identityDeletionProcesses.cancelIdentityDeletionProcess();

      final activeIdentityDeletionProcess = (await session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess()).value;

      final result = await session.transportServices.identityDeletionProcesses.getIdentityDeletionProcesses();
      expect(result, isSuccessful<List<IdentityDeletionProcessDTO>>());

      final identityDeletionProcesses = result.value;
      expect(identityDeletionProcesses.length, 2);
      expect(identityDeletionProcesses[0].id, cancelledIdentityDeletionProcess.id);
      expect(identityDeletionProcesses[0].status, IdentityDeletionProcessStatus.Cancelled);
      expect(identityDeletionProcesses[1].id, activeIdentityDeletionProcess.id);
      expect(identityDeletionProcesses[1].status, IdentityDeletionProcessStatus.Approved);
    });

    test('should return an empty list trying to get all IdentityDeletionProcesses if there are none', () async {
      // Initialize new Identities for these tests as otherwise they would be depending on the other tests
      await runtime.accountServices.offboardAccount(account.id);
      account = await runtime.accountServices.createAccount(name: 'identityDeletionProcessesFacade Test');
      session = runtime.getSession(account.id);

      final result = await session.transportServices.identityDeletionProcesses.getIdentityDeletionProcesses();
      expect(result, isSuccessful<List<IdentityDeletionProcessDTO>>());

      final identityDeletionProcesses = result.value;
      expect(identityDeletionProcesses.length, 0);
    });
  });

  group('Cancel IdentityDeletionProcess', () {
    test('should cancel an IdentityDeletionProcess', () async {
      await session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();
      eventBus.reset();

      final result = await session.transportServices.identityDeletionProcesses.cancelIdentityDeletionProcess();
      expect(result, isSuccessful<IdentityDeletionProcessDTO>());

      final identityDeletionProcess = result.value;
      expect(identityDeletionProcess.status, IdentityDeletionProcessStatus.Cancelled);

      final event = await eventBus.waitForEvent<IdentityDeletionProcessStatusChangedEvent>(eventTargetAddress: account.address!);
      expect(event.data.id, result.value.id);
      expect(event.data.status, IdentityDeletionProcessStatus.Cancelled);
    });

    test('should return an error trying to cancel an IdentityDeletionProcess if there is none active', () async {
      final result = await session.transportServices.identityDeletionProcesses.cancelIdentityDeletionProcess();
      expect(result, isFailing('error.runtime.identityDeletionProcess.noApprovedIdentityDeletionProcess'));
    });
  });

  group('Approve IdentityDeletionProcess', () {
    test(
      'should approve a waiting for approval IdentityDeletionProcess',
      () async {
        // start IdentityDeletionProcessFromBackboneAdminApi

        final result = await session.transportServices.identityDeletionProcesses.approveIdentityDeletionProcess();
        expect(result, isSuccessful<List<IdentityDeletionProcessDTO>>());

        final identityDeletionProcess = result.value;
        expect(identityDeletionProcess.status, IdentityDeletionProcessStatus.Approved);

        final event = await eventBus.waitForEvent<IdentityDeletionProcessStatusChangedEvent>(eventTargetAddress: account.address!);
        expect(event.data.id, identityDeletionProcess.id);
        expect(event.data.status, IdentityDeletionProcessStatus.Approved);
      },
      skip: 'skipped for now since we cannot start an IdentityDeletionProcess from the Backbone Admin API here',
    );

    test('should return an error trying to approve an IdentityDeletionProcess if there is none active', () async {
      final result = await session.transportServices.identityDeletionProcesses.approveIdentityDeletionProcess();
      expect(result, isFailing('error.runtime.identityDeletionProcess.noWaitingForApprovalIdentityDeletionProcess'));
    });
  });

  group('Reject IdentityDeletionProcess', () {
    test(
      'should reject a waiting for approval IdentityDeletionProcess',
      () async {
        // start IdentityDeletionProcessFromBackboneAdminApi

        final result = await session.transportServices.identityDeletionProcesses.rejectIdentityDeletionProcess();
        expect(result, isSuccessful<List<IdentityDeletionProcessDTO>>());

        final identityDeletionProcess = result.value;
        expect(identityDeletionProcess.status, IdentityDeletionProcessStatus.Rejected);

        final event = await eventBus.waitForEvent<IdentityDeletionProcessStatusChangedEvent>(eventTargetAddress: account.address!);
        expect(event.data.id, identityDeletionProcess.id);
        expect(event.data.status, IdentityDeletionProcessStatus.Rejected);
      },
      skip: 'skipped for now since we cannot start an IdentityDeletionProcess from the Backbone Admin API here',
    );

    test('should return an error trying to reject an IdentityDeletionProcess if there is none active', () async {
      final result = await session.transportServices.identityDeletionProcesses.rejectIdentityDeletionProcess();
      expect(result, isFailing('error.runtime.identityDeletionProcess.noWaitingForApprovalIdentityDeletionProcess'));
    });
  });
}
