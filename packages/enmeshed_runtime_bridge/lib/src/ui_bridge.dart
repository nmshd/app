import 'package:enmeshed_types/enmeshed_types.dart';

typedef UIBridgeError = ({String code, String message, Map<String, dynamic>? data});

enum UIBridgePasswordType { password, pin }

abstract class UIBridge {
  Future<void> showMessage(
    LocalAccountDTO account,
    IdentityDVO relationship,

    /// can also be [MailDVO] or [RequestMessageDVO]
    MessageDVO message,
  );

  Future<void> showRelationship(LocalAccountDTO account, IdentityDVO relationship);

  Future<void> showFile(LocalAccountDTO account, FileDVO file);

  Future<void> showDeviceOnboarding(DeviceSharedSecret deviceOnboardingInfo);

  Future<void> showRequest(LocalAccountDTO account, LocalRequestDVO request);

  Future<void> showError(UIBridgeError error, [LocalAccountDTO? account]);

  Future<LocalAccountDTO?> requestAccountSelection(List<LocalAccountDTO> possibleAccounts, [String? title, String? description]);

  Future<String?> enterPassword({required UIBridgePasswordType passwordType, int? pinLength, int? attempt, int? passwordLocationIndicator});
}
