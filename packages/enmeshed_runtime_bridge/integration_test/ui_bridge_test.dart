import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import 'setup.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime enmeshedRuntime) {
  final uiBridge = FakeUIBridge();

  setUpAll(() async {
    enmeshedRuntime.registerUIBridge(uiBridge);
  });
}

class FakeUIBridge implements UIBridge {
  final requestAccountSelectionCalls = List<(List<LocalAccountDTO>, String?, String?)>.empty();
  bool get requestAccountSelectionCalled => requestAccountSelectionCalls.isNotEmpty;

  final showDeviceOnboardingCalls = List<DeviceSharedSecret>.empty();
  bool get showDeviceOnboardingCalled => showDeviceOnboardingCalls.isNotEmpty;

  final showErrorCalls = List<(UIBridgeError, LocalAccountDTO?)>.empty();
  bool get showErrorCalled => showErrorCalls.isNotEmpty;

  final showFileCalls = List<(LocalAccountDTO, FileDVO)>.empty();
  bool get showFileCalled => showFileCalls.isNotEmpty;

  final showMessageCalls = List<(LocalAccountDTO, IdentityDVO, MessageDVO)>.empty();
  bool get showMessageCalled => showMessageCalls.isNotEmpty;

  final showRelationshipCalls = List<(LocalAccountDTO, IdentityDVO)>.empty();
  bool get showRelationshipCalled => showRelationshipCalls.isNotEmpty;

  final showRequestCalls = List<(LocalAccountDTO, LocalRequestDVO)>.empty();
  bool get showRequestCalled => showRequestCalls.isNotEmpty;

  @override
  Future<LocalAccountDTO?> requestAccountSelection(List<LocalAccountDTO> possibleAccounts, [String? title, String? description]) async {
    requestAccountSelectionCalls.add((possibleAccounts, title, description));

    return null;
  }

  @override
  Future<void> showDeviceOnboarding(DeviceSharedSecret deviceOnboardingInfo) async => showDeviceOnboardingCalls.add(deviceOnboardingInfo);

  @override
  Future<void> showError(UIBridgeError error, [LocalAccountDTO? account]) async => showErrorCalls.add((error, account));

  @override
  Future<void> showFile(LocalAccountDTO account, FileDVO file) async => showFileCalls.add((account, file));

  @override
  Future<void> showMessage(LocalAccountDTO account, IdentityDVO relationship, MessageDVO message) async =>
      showMessageCalls.add((account, relationship, message));

  @override
  Future<void> showRelationship(LocalAccountDTO account, IdentityDVO relationship) async => showRelationshipCalls.add((account, relationship));

  @override
  Future<void> showRequest(LocalAccountDTO account, LocalRequestDVO request) async => showRequestCalls.add((account, request));
}
