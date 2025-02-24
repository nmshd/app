import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../generated/l10n/app_localizations.dart';
import 'globals.dart';
import 'utils/settings_utils.dart';
import 'utils/snackbars.dart';
import 'types/error_details.dart';
class AppUIBridge extends UIBridge {
  final Logger logger;
  final GoRouter router;
  final AppLocalizations localizations;

  AppUIBridge({required this.logger, required this.router, required this.localizations});

  @override
  Future<LocalAccountDTO?> requestAccountSelection(List<LocalAccountDTO> possibleAccounts, [String? title, String? description]) async {
    logger.d('requestAccountSelection for accounts ${possibleAccounts.map((e) => e.id).toList()} with title $title and description $description');

    final extra = (possibleAccounts: possibleAccounts, title: title, description: description);
    final selectedAccount = await router.push('/select-profile-popup', extra: extra);
    if (selectedAccount is LocalAccountDTO) {
      logger.d('requestAccountSelection selected account ${selectedAccount.id}');
      return selectedAccount;
    }

    logger.d('requestAccountSelection no account selected');

    return null;
  }

  @override
  Future<void> showDeviceOnboarding(DeviceSharedSecret deviceOnboardingInfo) async {
    logger.d('showDeviceOnboarding for device ${deviceOnboardingInfo.id}');

    if (!deviceOnboardingInfo.isBackupDevice) {
      await router.push('/device-onboarding', extra: deviceOnboardingInfo);
      return;
    }

    await _useRecoveryKit(deviceOnboardingInfo);
  }

  Future<void> _useRecoveryKit(DeviceSharedSecret deviceOnboardingInfo) async {
    final runtime = GetIt.I.get<EnmeshedRuntime>();

    late LocalAccountDTO onboardedAccount;
    try {
      onboardedAccount = await runtime.accountServices.onboardAccount(deviceOnboardingInfo, name: deviceOnboardingInfo.profileName);
    } on Exception catch (e) {
      if (e.toString().contains('error.app-runtime.onboardedAccountAlreadyExists')) {
        router.pop();
        await router.push('/error-dialog', extra: 'error.app-runtime.onboardedAccountAlreadyExists');

        return;
      }

      router.pop();
      await router.push('/error-dialog', extra: 'error.recordNotFoundOnScanRecoveryKit');
      return;
    }

    await upsertRestoreFromIdentityRecoveryKitSetting(accountId: onboardedAccount.id, value: true);

    final accountsNotInDeletion = await runtime.accountServices.getAccountsNotInDeletion();

    final isOnboardedAccountInDeletion = !accountsNotInDeletion.any((element) => element.id == onboardedAccount.id);
    if (!isOnboardedAccountInDeletion) {
      await runtime.selectAccount(onboardedAccount.id);
      router.go('/account/${onboardedAccount.id}');

      snackbarKey.currentState?.showSuccessSnackbar(text: localizations.restoreFromIdentityRecovery_success);
      return;
    }

    if (accountsNotInDeletion.isEmpty) {
      await router.push('/onboarding?skipIntroduction=true');
      snackbarKey.currentState?.showSuccessSnackbar(text: localizations.restoreFromIdentityRecovery_success_butInDeletion);
      return;
    }

    accountsNotInDeletion.sort((a, b) => b.lastAccessedAt?.compareTo(a.lastAccessedAt ?? '') ?? 0);
    final account = accountsNotInDeletion.first;

    await runtime.selectAccount(account.id);

    snackbarKey.currentState?.showSuccessSnackbar(text: localizations.restoreFromIdentityRecovery_success_butInDeletion);

    router.go('/account/${account.id}');
    await router.push('/profiles');
  }

  @override
  Future<void> showError(UIBridgeError error, [LocalAccountDTO? account]) async {
    logger.d('showError for account ${account?.id} error $error');

    await router.push('/error-dialog', extra: createErrorDetails(errorCode: error.code));
  }

  @override
  Future<void> showFile(LocalAccountDTO account, FileDVO file) async {
    logger.d('showFile for account ${account.id} id ${file.id}');
    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

    router.go('/account/${account.id}/my-data/files/${file.id}');
  }

  @override
  Future<void> showMessage(LocalAccountDTO account, IdentityDVO relationship, MessageDVO message) async {
    logger.d('showMessage for account ${account.id} id ${message.id}');
    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

    router.go('/account/${account.id}/mailbox/${message.id}');
  }

  @override
  Future<void> showRelationship(LocalAccountDTO account, IdentityDVO relationship) async {
    logger.d('showRelationship for account ${account.id} id ${relationship.id}');

    router.go('/account/${account.id}/contacts/${relationship.id}');
  }

  @override
  Future<void> showRequest(LocalAccountDTO account, LocalRequestDVO request) async {
    logger.d('showRequest for account ${account.id} id ${request.id}');
    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

    router.go('/account/${account.id}/contacts/contact-request/${request.id}', extra: request);
  }

  @override
  Future<String?> enterPassword({required UIBridgePasswordType passwordType, int? pinLength, int? attempt}) async {
    final extra = (passwordType: passwordType, pinLength: pinLength, attempt: attempt);
    final password = await router.push('/enter-password-popup', extra: extra);
    if (password is String) {
      logger.d('enterPassword entered $password');
      return password;
    }

    logger.d('enterPassword no password entered');

    return null;
  }
}
