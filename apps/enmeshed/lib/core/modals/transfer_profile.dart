import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../utils/utils.dart';

Future<void> showTransferProfileModal({required BuildContext context}) async {
  if (!context.mounted) return;

  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: false,
    isScrollControlled: true,
    builder: (context) => const _TransferProfileModal(),
  );
}

class _TransferProfileModal extends StatefulWidget {
  const _TransferProfileModal();

  @override
  State<_TransferProfileModal> createState() => _TransferProfileModalState();
}

class _TransferProfileModalState extends State<_TransferProfileModal> {
  EmptyTokenDTO? _token;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _refreshQRCode();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(title: context.l10n.transferProfile_title),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 32,
              children: [
                BoldStyledText(context.l10n.transferProfile_presentQRCode_description),
                Card(
                  margin: EdgeInsets.zero,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: Center(
                    child: (_token == null)
                        ? const SizedBox(
                            width: 200,
                            height: 200,
                            child: Padding(padding: EdgeInsets.all(50), child: CircularProgressIndicator()),
                          )
                        : QrImageView(
                            data: _token!.reference.url,
                            size: 200,
                            dataModuleStyle: QrDataModuleStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              dataModuleShape: QrDataModuleShape.square,
                            ),
                            eyeStyle: QrEyeStyle(color: Theme.of(context).colorScheme.onSurface, eyeShape: QrEyeShape.square),
                          ),
                  ),
                ),
                FilledButton.tonalIcon(
                  onPressed: _token == null ? null : () => Clipboard.setData(ClipboardData(text: _token!.reference.url)),
                  label: Text(context.l10n.onboarding_transferProfile_copyUrlLink),
                  icon: const Icon(Icons.file_copy_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startTimer() => _timer = Timer.periodic(const Duration(seconds: 3), _checkStatus);

  Future<void> _checkStatus(Timer timer) async {
    final token = _token;
    if (token == null) return;

    if (DateTime.parse(token.expiresAt).isBefore(DateTime.now().subtract(const Duration(seconds: 10)))) {
      GetIt.I.get<Logger>().i('Token expired, refreshing QR code...');
      await _refreshQRCode();
      return;
    }

    final fetchedToken = await GetIt.I.get<EnmeshedRuntime>().anonymousServices.tokens.loadPeerToken(token.reference.truncated);
    if (fetchedToken.isError && fetchedToken.error.code == 'error.transport.tokens.emptyToken') {
      return;
    } else if (fetchedToken.isError) {
      GetIt.I.get<Logger>().e('An error occurred when trying to fetch the token: ${fetchedToken.error.code}');
      await _refreshQRCode();

      return;
    }

    _timer.cancel();

    if (!mounted) return;

    setState(() => _token = null);

    GetIt.I.get<Logger>().i('Token was filled: ${fetchedToken.value.content}');

    final content = fetchedToken.value.content;

    if (content is! TokenContentDeviceSharedSecret) {
      GetIt.I.get<Logger>().e('Token content is not a DeviceSharedSecret: $content');
      await context.push('/error-dialog', extra: 'error.transferProfile.transferFailed');
      await _refreshQRCode();
      _startTimer();
      return;
    }

    if (!mounted) return;

    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    final deviceName = deviceInfo.deviceName;

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    try {
      final account = await runtime.accountServices.onboardAccount(
        content.sharedSecret,
        name: content.sharedSecret.profileName,
        deviceName: deviceName,
      );

      await runtime.selectAccount(account.id);

      if (mounted) {
        showSuccessSnackbar(context: context, text: 'Das Profil <bold>${account.name}</bold> wurde erfolgreich übertragen.');
        context.go('/account/${account.id}/home');
        unawaited(context.push('/profiles'));
      }
    } on Exception {
      if (!mounted) return;

      await showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (context) => const _ProfileAlreadyExistsDialog(),
      );

      await _refreshQRCode();
      _startTimer();
    }
  }

  Future<void> _refreshQRCode() async {
    if (_token != null) setState(() => _token = null);

    final response = await GetIt.I.get<EnmeshedRuntime>().anonymousServices.tokens.createEmptyToken();
    if (!mounted || response.isError) return;

    setState(() => _token = response.value);
  }
}

class _ProfileAlreadyExistsDialog extends StatelessWidget {
  const _ProfileAlreadyExistsDialog();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        icon: Icon(Icons.error, color: Theme.of(context).colorScheme.error),
        title: Text(context.l10n.onboarding_alreadyExist_title),
        content: Text(context.l10n.onboarding_alreadyExist_description, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [OutlinedButton(onPressed: context.pop, child: Text(context.l10n.back))],
      ),
    );
  }
}
