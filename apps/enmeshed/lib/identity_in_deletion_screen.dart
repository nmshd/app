import 'package:enmeshed/profiles/profile/widgets/profile_card.dart';
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

    _loadAccountsInDeletion();
  }

  @override
  Widget build(BuildContext context) {
    if (_accounts == null || _accountsInDeletion == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Das derzeit aktive Profil ${widget.accountName} wurde in Löschung versetzt.',
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
                  const Text(
                    textAlign: TextAlign.center,
                    'Sie haben die Löschung dieses Profils auf einem anderen Gerät angestoßen. Es befindet sich ein weiteres Profil auf ihrem Gerät. Wählen Sie das Profil aus um fortfzuahren oder erstellen Sie ein neues Profil.\n\nWenn Sie die Löschung des Profil nicht angestoßen haben können Sie das Profil wiederherstellen.',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: FilledButton(
                      onPressed: () => context.go('/onboarding?skipIntroduction=true'),
                      child: const Text('Neues Profil erstellen'),
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

  Future<void> _loadAccountsInDeletion() async {
    final runtime = GetIt.I.get<EnmeshedRuntime>();
    final accountsInDeletion = await runtime.accountServices.getAccountsInDeletion();
    final accounts = await runtime.accountServices.getAccountsNotInDeletion();
    accounts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    if (!mounted) return;

    setState(() {
      //_accounts = accounts.where((account) => account.id != selectedAccount.id).toList();
      _accounts = accounts;
      _accountsInDeletion = accountsInDeletion;
    });
  }
}

