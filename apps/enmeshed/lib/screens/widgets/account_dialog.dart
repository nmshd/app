import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../onboarding_screen.dart';
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
            Stack(
              alignment: Alignment.center,
              children: [
                const Align(alignment: Alignment.topLeft, child: CloseButton()),
                SizedBox(
                  height: 35,
                  child: Image.asset(
                    MediaQuery.of(context).platformBrightness == Brightness.light
                        ? 'assets/enmeshed_logo_light_cut.png'
                        : 'assets/enmeshed_logo_dark_cut.png',
                    fit: BoxFit.contain,
                  ),
                ),
                if (kDebugMode)
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () async {
                        await GetIt.I.get<EnmeshedRuntime>().accountServices.clearAccounts();
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                            (_) => false,
                          );
                        }
                      },
                      icon: const Icon(Icons.delete_forever),
                    ),
                  ),
              ],
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: _openDataPrivacy,
                  child: Text(
                    AppLocalizations.of(context)!.menu_dataPrivacy,
                    style: const TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ),
                const Text(' · '),
                InkWell(
                  onTap: () => showLicensePage(context: context),
                  child: Text(
                    AppLocalizations.of(context)!.menu_licenses,
                    style: const TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openDataPrivacy() async {
    final url = Uri.parse('https://enmeshed.eu/privacy');

    if (!await canLaunchUrl(url)) {
      GetIt.I.get<Logger>().e('Could not launch $url');
      return;
    }

    try {
      await launchUrl(url);
    } catch (e) {
      GetIt.I.get<Logger>().e(e);
    }
  }

  void _reloadAccounts() async {
    final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
    accounts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    setState(() => _accounts = accounts);
  }
}
