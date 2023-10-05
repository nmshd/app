import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'create_new_identity.dart';

class AccountDialog extends StatefulWidget {
  final Function(LocalAccountDTO) accountsChanged;
  final LocalAccountDTO initialSelectedAccount;

  const AccountDialog({super.key, required this.accountsChanged, required this.initialSelectedAccount});

  @override
  State<AccountDialog> createState() => _AccountDialogState();
}

class _AccountDialogState extends State<AccountDialog> {
  List<LocalAccountDTO>? _accounts;
  late LocalAccountDTO _selectedAccount;

  @override
  void initState() {
    super.initState();

    _selectedAccount = widget.initialSelectedAccount;
    _reloadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_accounts == null) const Center(child: CircularProgressIndicator()),
            if (_accounts != null) ...[
              const Divider(),
              for (final account in _accounts!)
                ListTile(
                  leading: CircleAvatar(child: Text(account.name.substring(0, account.name.length > 2 ? 2 : account.name.length))),
                  title: Text(account.name),
                  selected: _selectedAccount.id == account.id,
                  onTap: () async {
                    setState(() => _selectedAccount = account);

                    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);
                    widget.accountsChanged(account);
                    _reloadAccounts();
                  },
                ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Create new account'),
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (_) => CreateNewIdentity(
                    onAccountCreated: (account) async {
                      setState(() => _selectedAccount = account);

                      await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);
                      widget.accountsChanged(account);
                      _reloadAccounts();
                    },
                  ),
                ),
              ),
            ],
            const Divider(),
          ],
        ),
      ),
    );
  }

  void _reloadAccounts() async {
    final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
    accounts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    setState(() => _accounts = accounts);
  }
}
