import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import 'create_new_identity.dart';

class AccountDialog extends StatefulWidget {
  final Function(LocalAccountDTO) accountsChanged;

  const AccountDialog({super.key, required this.accountsChanged});

  @override
  State<AccountDialog> createState() => _AccountDialogState();
}

class _AccountDialogState extends State<AccountDialog> {
  List<LocalAccountDTO>? _accounts;

  @override
  void initState() {
    super.initState();

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
                  height: 24,
                  child: Image.asset(
                    MediaQuery.of(context).platformBrightness == Brightness.light
                        ? 'assets/enmeshed_logo_light_cut.png'
                        : 'assets/enmeshed_logo_dark_cut.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            if (_accounts == null) const Center(child: CircularProgressIndicator()),
            if (_accounts != null) ...[
              const Divider(),
              for (final entry in _accounts!.asMap().entries)
                ListTile(
                  leading: CircleAvatar(child: Text(entry.value.name.substring(0, 2))),
                  title: Text(entry.value.name),
                  selected: entry.key == 0,
                  onTap: () async {
                    await GetIt.I.get<EnmeshedRuntime>().selectAccount(entry.value.id);
                    widget.accountsChanged(entry.value);
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
    accounts.sort((a, b) => b.lastAccessedAt?.compareTo(a.lastAccessedAt ?? '') ?? 0);
    setState(() => _accounts = accounts);
  }
}
