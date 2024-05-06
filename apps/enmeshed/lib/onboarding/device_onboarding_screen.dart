import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class DeviceOnboardingScreen extends StatefulWidget {
  final DeviceSharedSecret deviceSharedSecret;

  const DeviceOnboardingScreen({required this.deviceSharedSecret, super.key});

  @override
  State<DeviceOnboardingScreen> createState() => _DeviceOnboardingScreenState();
}

class _DeviceOnboardingScreenState extends State<DeviceOnboardingScreen> {
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
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.deviceOnboarding_title)),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.deviceOnboarding_desciption),
              Gaps.h16,
              Text.rich(
                TextSpan(
                  text: context.l10n.deviceOnboarding_deviceName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [TextSpan(text: widget.deviceSharedSecret.name)],
                ),
              ),
              if (widget.deviceSharedSecret.description != null && widget.deviceSharedSecret.description!.isNotEmpty)
                Text.rich(
                  TextSpan(
                    text: context.l10n.deviceOnboarding_deviceDescription,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    children: [TextSpan(text: widget.deviceSharedSecret.description)],
                  ),
                ),
              Gaps.h24,
              Text(context.l10n.deviceOnboarding_confirmation_text),
              const Spacer(),
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
                  suffixIcon: IconButton(
                    onPressed: _controller.clear,
                    icon: const Icon(Icons.cancel_outlined),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              Gaps.h16,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: _otherAccounts == null ? null : _cancel,
                    child: Text(context.l10n.cancel),
                  ),
                  Gaps.w8,
                  FilledButton(
                    onPressed: _otherAccounts == null ? null : _onboardDevice,
                    child: Text(context.l10n.deviceOnboarding_confirm),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onboardDevice() async {
    unawaited(showLoadingDialog(context, context.l10n.deviceOnboarding_inProgress));

    if (_defaultProfileName == null) return;

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final profileName = _controller.text.isEmpty ? _defaultProfileName! : _controller.text;
    final account = await runtime.accountServices.onboardAccount(widget.deviceSharedSecret, name: profileName);
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

  const _ProfileAlreadyExistsDialog({
    required this.existingAccount,
    required this.onBackPressed,
  });

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
