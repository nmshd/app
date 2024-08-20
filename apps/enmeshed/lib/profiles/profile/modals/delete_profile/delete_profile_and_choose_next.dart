import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import '../../widgets/profile_card.dart';

class DeleteProfileAndChooseNext extends StatefulWidget {
  final LocalAccountDTO localAccount;
  final ValueNotifier<Future<void>?> deleteFuture;
  final Future<void> Function()? retryFunction;
  final String successDescription;
  final String inProgressText;

  const DeleteProfileAndChooseNext({
    required this.localAccount,
    required this.deleteFuture,
    required this.retryFunction,
    required this.successDescription,
    required this.inProgressText,
    super.key,
  });

  @override
  State<DeleteProfileAndChooseNext> createState() => _DeleteProfileAndChooseNextState();
}

class _DeleteProfileAndChooseNextState extends State<DeleteProfileAndChooseNext> {
  Exception? _exception;
  List<LocalAccountDTO>? _accounts;

  @override
  void initState() {
    super.initState();

    if (widget.deleteFuture.value != null) {
      _handleFuture(widget.deleteFuture.value!);
    } else {
      widget.deleteFuture.addListener(() {
        _handleFuture(widget.deleteFuture.value!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: switch ((_exception, _accounts)) {
        (Exception(), _) => _Error(
            onRetry: () async {
              setState(() => _exception = null);
              if (widget.retryFunction != null) _handleFuture(widget.retryFunction!());
            },
          ),
        (_, null) => _Loading(inProgressText: widget.inProgressText),
        (_, []) => const _Empty(),
        (_, _) => _AccountsAvailable(accounts: _accounts!, successDescription: widget.successDescription),
      },
    );
  }

  void _handleFuture(Future<void> future) => future.then((_) => _loadAccounts()).onError(
        (error, stackTrace) {
          GetIt.I.get<Logger>().e('Failed to delete account $error');
          setState(() => _exception = Exception('Failed to delete account'));
        },
      );

  Future<void> _loadAccounts() async {
    final accounts = await getAccountsNotInDeletion();

    accounts.sort((a, b) => a.name.compareTo(b.name));

    if (mounted) setState(() => _accounts = accounts);
  }
}

class _Error extends StatelessWidget {
  final VoidCallback onRetry;

  const _Error({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Column(
        children: [
          Icon(Icons.cancel, size: 160, color: Theme.of(context).colorScheme.error),
          Gaps.h24,
          Text(
            context.l10n.profile_delete_error,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.profile_delete_error_cancel)),
              Gaps.w8,
              FilledButton(onPressed: onRetry, child: Text(context.l10n.profile_delete_error_retry)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  final String inProgressText;

  const _Loading({required this.inProgressText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(inProgressText, style: Theme.of(context).textTheme.headlineSmall),
          Gaps.h24,
          const SizedBox(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Column(
        children: [
          Icon(Icons.check_circle_rounded, size: 160, color: context.customColors.successIcon),
          Gaps.h24,
          Text(context.l10n.profile_delete_success_noProfilesAvailable, style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () => context.go('/onboarding?skipIntroduction=true'),
              child: Text(context.l10n.profile_delete_success_noProfilesAvailable_okay),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountsAvailable extends StatelessWidget {
  final List<LocalAccountDTO> accounts;
  final String successDescription;

  const _AccountsAvailable({required this.accounts, required this.successDescription});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
        child: Column(
          children: [
            Icon(Icons.check_circle_rounded, size: 160, color: context.customColors.successIcon),
            Gaps.h24,
            Text(successDescription, style: Theme.of(context).textTheme.bodyMedium),
            Gaps.h24,
            Column(
              children: accounts
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ProfileCard(
                        account: e,
                        onAccountSelected: (_) => _onAccountSelected(e, context),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onAccountSelected(LocalAccountDTO account, BuildContext context) async {
    if (context.mounted) context.go('/account/${account.id}');
    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
          content: Row(
            children: [
              Icon(Icons.check_circle_rounded, color: context.customColors.successIcon),
              Gaps.w8,
              Expanded(child: Text(context.l10n.profiles_switchedToProfile(account.name))),
            ],
          ),
        ),
      );
    }
  }
}
