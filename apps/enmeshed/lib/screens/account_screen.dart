import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

class AccountScreen extends StatefulWidget {
  late final Session session;

  AccountScreen(String accountId, {super.key}) : session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async => await GetIt.I.get<EnmeshedRuntime>().accountServices.clearAccounts(),
            icon: const Icon(Icons.clear),
          ),
        ],
        title: Text(_title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.overview,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_alt_outlined),
            label: AppLocalizations.of(context)!.contacts,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.edit_document),
            label: AppLocalizations.of(context)!.myData,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  String get _title {
    switch (_selectedIndex) {
      case 0:
        return AppLocalizations.of(context)!.overview;
      case 1:
        return AppLocalizations.of(context)!.contacts;
      case 2:
        return AppLocalizations.of(context)!.myData;
      default:
        return '';
    }
  }
}
