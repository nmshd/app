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
  DeviceSharedSecret? _sharedSecret;

  @override
  Widget build(BuildContext context) {
    return KeyboardAwareSafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(title: context.l10n.transferProfile_title),
          AnimatedSwitcher(
            layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Stack(alignment: Alignment.center, children: [...previousChildren, ?currentChild]),
              );
            },
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeInOut)),
                ),
                child: child,
              );
            },
            child: _sharedSecret == null
                ? _TransferProfileScan(setSharedSecret: (sharedSecret) => setState(() => _sharedSecret = sharedSecret))
                : _FinalizeProfileTransfer(deviceSharedSecret: _sharedSecret!),
          ),
        ],
      ),
    );
  }
}

class _TransferProfileScan extends StatefulWidget {
  final void Function(DeviceSharedSecret sharedSecret) setSharedSecret;

  const _TransferProfileScan({required this.setSharedSecret});

  @override
  State<_TransferProfileScan> createState() => _TransferProfileScanState();
}

class _TransferProfileScanState extends State<_TransferProfileScan> {
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
    return Padding(
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
                      dataModuleStyle: QrDataModuleStyle(color: Theme.of(context).colorScheme.onSurface, dataModuleShape: QrDataModuleShape.square),
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

    widget.setSharedSecret(content.sharedSecret);
  }

  Future<void> _refreshQRCode() async {
    if (_token != null) setState(() => _token = null);

    final response = await GetIt.I.get<EnmeshedRuntime>().anonymousServices.tokens.createEmptyToken();
    if (!mounted || response.isError) return;

    setState(() => _token = response.value);
  }
}

class _FinalizeProfileTransfer extends StatefulWidget {
  final DeviceSharedSecret deviceSharedSecret;

  const _FinalizeProfileTransfer({required this.deviceSharedSecret});

  @override
  State<_FinalizeProfileTransfer> createState() => _FinalizeProfileTransferState();
}

class _FinalizeProfileTransferState extends State<_FinalizeProfileTransfer> {
  List<LocalAccountDTO>? _otherAccounts;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  String? _defaultProfileName;

  @override
  void initState() {
    super.initState();

    _loadDefaultProfileName();

    _focusNode.requestFocus();

    _controller.addListener(() => setState(() {}));

    _loadAccounts();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.transferProfile_finalize_description),
          Gaps.h24,
          TextField(
            enabled: _defaultProfileName != null,
            maxLength: MaxLength.profileName,
            controller: _controller,
            focusNode: _focusNode,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: context.l10n.onboarding_enterProfileName,
              hintText: _defaultProfileName,
              suffixIcon: IconButton(onPressed: _controller.clear, icon: const Icon(Icons.cancel_outlined)),
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ),
          Gaps.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: _otherAccounts == null ? null : _cancel, child: Text(context.l10n.cancel)),
              Gaps.w8,
              FilledButton(onPressed: _otherAccounts == null ? null : _onboardDevice, child: Text(context.l10n.transferProfile_finalize_accept)),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onboardDevice() async {
    unawaited(showLoadingDialog(context, context.l10n.deviceOnboarding_inProgress));

    if (_defaultProfileName == null) return;

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final profileName = _controller.text.isEmpty ? _defaultProfileName! : _controller.text;

    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    final deviceName = deviceInfo.deviceName;

    final account = await runtime.accountServices.onboardAccount(widget.deviceSharedSecret, name: profileName, deviceName: deviceName);
    await runtime.selectAccount(account.id);

    if (mounted) {
      context.go('/account/${account.id}/home');
      unawaited(context.push('/account/${account.id}/devices'));
    }
  }

  Future<void> _cancel() async {
    if (context.canPop()) context.pop();

    final accounts = _otherAccounts!;
    if (accounts.isEmpty) return context.go('/onboarding?skipIntroduction=true');

    accounts.sort((a, b) => b.lastAccessedAt?.compareTo(a.lastAccessedAt ?? '') ?? 0);

    final account = accounts.first;

    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

    if (mounted) {
      context.go('/account/${account.id}');
      await context.push('/profiles');
    }
  }

  Future<void> _loadDefaultProfileName() async {
    if (widget.deviceSharedSecret.profileName != null) {
      setState(() => _defaultProfileName = widget.deviceSharedSecret.profileName);
      return;
    }

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    final profiles = await runtime.accountServices.getAccounts();

    if (mounted) {
      setState(() {
        _defaultProfileName = '${context.l10n.onboarding_defaultIdentityName} ${profiles.length + 1}';
      });
    }
  }

  Future<void> _loadAccounts() async {
    final otherAccounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
    if (!mounted) return;

    final existingAccount = otherAccounts.where((e) => e.address == widget.deviceSharedSecret.identity.address).firstOrNull;
    if (existingAccount != null) {
      unawaited(
        showDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (context) => _ProfileAlreadyExistsDialog(existingAccount: existingAccount, onBackPressed: _cancel),
        ),
      );

      return;
    }

    setState(() => _otherAccounts = otherAccounts);
  }
}

class _ProfileAlreadyExistsDialog extends StatelessWidget {
  final LocalAccountDTO existingAccount;
  final VoidCallback onBackPressed;

  const _ProfileAlreadyExistsDialog({required this.existingAccount, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        icon: Icon(Icons.error, color: Theme.of(context).colorScheme.error),
        title: Text(context.l10n.onboarding_alreadyExist_title),
        content: Text(context.l10n.onboarding_alreadyExist_description, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          OutlinedButton(
            onPressed: () async {
              context.pop();

              onBackPressed();
            },
            child: Text(context.l10n.back),
          ),
        ],
      ),
    );
  }
}
