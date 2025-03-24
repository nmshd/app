import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

import 'core/core.dart';

class IdentityInDeletionScreen extends StatefulWidget {
  final String accountName;

  const IdentityInDeletionScreen({required this.accountName, super.key});

  @override
  State<IdentityInDeletionScreen> createState() => _IdentityInDeletionScreenState();
}

class _IdentityInDeletionScreenState extends State<IdentityInDeletionScreen> {
  List<LocalAccountDTO>? _accountsInDeletion;
  List<LocalAccountDTO>? _accounts;

  @override
  void initState() {
    super.initState();

    _loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    if (_accounts == null || _accountsInDeletion == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      context.l10n.identityInDeletion_title(widget.accountName),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.h16,
                  const Align(
                    alignment: Alignment.topCenter,
                    child: VectorGraphic(height: 160, loader: AssetBytesLoader('assets/svg/unexpected_error.svg')),
                  ),
                  Gaps.h32,
                  Text(textAlign: TextAlign.center, context.l10n.identityInDeletion_description),
                  Gaps.h32,
                  if (_accountsInDeletion!.isNotEmpty) _ProfilesInDeletion(accountsInDeletion: _accountsInDeletion!),
                  if (_accounts!.isNotEmpty) ...[Gaps.h12, _Profiles(accounts: _accounts!)],
                  Gaps.h16,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: FilledButton(
                      onPressed: () => context.go('/onboarding?skipIntroduction=true'),
                      child: Text(context.l10n.identityInDeletion_createNewProfile),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadAccounts() async {
    final runtime = GetIt.I.get<EnmeshedRuntime>();
    final accountsInDeletion = await runtime.accountServices.getAccountsInDeletion();
    final accounts = await runtime.accountServices.getAccountsNotInDeletion();

    if (!mounted) return;

    setState(() {
      _accounts = accounts;
      _accountsInDeletion = accountsInDeletion;
    });
  }
}

class _Profiles extends StatelessWidget {
  final List<LocalAccountDTO> accounts;

  const _Profiles({required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Gaps.h12,
          itemCount: accounts.length,
          itemBuilder:
              (context, index) => ProfileCard(account: accounts[index], onAccountSelected: (account) => _onAccountSelected(account, context)),
        ),
      ],
    );
  }

  Future<void> _onAccountSelected(LocalAccountDTO account, BuildContext context) async {
    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

    if (!context.mounted) return;

    context.go('/account/${account.id}');
    showSuccessSnackbar(context: context, text: context.l10n.profiles_switchedToProfile(account.name), showCloseIcon: true);
  }
}

class _ProfilesInDeletion extends StatelessWidget {
  final List<LocalAccountDTO> accountsInDeletion;

  const _ProfilesInDeletion({required this.accountsInDeletion});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Gaps.h12,
          itemCount: accountsInDeletion.length,
          itemBuilder:
              (context, index) => DeletionProfileCard(
                accountInDeletion: accountsInDeletion[index],
                trailing: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => showRestoreIdentityModal(accountInDeletion: accountsInDeletion[index], context: context),
                  tooltip: context.l10n.identity_restore,
                ),
              ),
        ),
      ],
    );
  }
}
