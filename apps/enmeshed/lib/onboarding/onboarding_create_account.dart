import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/core.dart';

class OnboardingCreateAccount extends StatefulWidget {
  final VoidCallback goToOnboardingAccount;

  const OnboardingCreateAccount({required this.goToOnboardingAccount, super.key});

  @override
  State<OnboardingCreateAccount> createState() => _OnboardingCreateAccountState();
}

class _OnboardingCreateAccountState extends State<OnboardingCreateAccount> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _showEnterProfileNameModal());
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 150, width: 150, child: CircularProgressIndicator(strokeWidth: 16)),
          Gaps.h32,
          Text(
            context.l10n.onboarding_creatingAccount,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Future<void> _showEnterProfileNameModal() async {
    final defaultProfileName = '${context.l10n.onboarding_defaultIdentityName} 1';

    final newProfileName = await WoltModalSheet.show<String?>(
      context: context,
      barrierDismissible: true,
      enableDrag: true,
      useSafeArea: false,
      pageListBuilder: (context) => [
        WoltModalSheetPage(
          leadingNavBarWidget: Padding(
            padding: const EdgeInsets.only(left: 24, top: 20),
            child: Text(context.l10n.onboarding_enterProfileName, style: Theme.of(context).textTheme.titleLarge),
          ),
          trailingNavBarWidget: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
          ),
          child: _EnterProfileNameDialog(defaultProfileName: defaultProfileName),
        ),
      ],
    );

    if (mounted) {
      await _createNewIdentity(
        newProfileName != null && newProfileName.isNotEmpty ? newProfileName : defaultProfileName,
      );
    }
  }

  Future<void> _createNewIdentity(String accountName) async {
    try {
      final account = await GetIt.I.get<EnmeshedRuntime>().accountServices.createAccount(name: accountName);

      await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);
      if (mounted) context.go('/account/${account.id}');
    } catch (e) {
      GetIt.I.get<Logger>().e(e.toString());
      if (mounted) {
        context.pop();

        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
              content: Text(context.l10n.error_createAccount),
            );
          },
        );

        widget.goToOnboardingAccount();
      }
    }
  }
}

class _EnterProfileNameDialog extends StatefulWidget {
  final String defaultProfileName;

  const _EnterProfileNameDialog({required this.defaultProfileName});

  @override
  State<_EnterProfileNameDialog> createState() => _EnterProfileNameDialogState();
}

class _EnterProfileNameDialogState extends State<_EnterProfileNameDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 24, left: 24, right: 24),
      child: Column(
        children: [
          TextField(
            maxLength: MaxLength.profileName,
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: widget.defaultProfileName,
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
            onSubmitted: (text) => context.pop(text),
          ),
          Gaps.h16,
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: () => context.pop(_controller.text),
              style: FilledButton.styleFrom(minimumSize: const Size(100, 36)),
              child: Text(context.l10n.onboarding_acceptProfileName),
            ),
          ),
        ],
      ),
    );
  }
}
