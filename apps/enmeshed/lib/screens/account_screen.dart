import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/foundation.dart';
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

  static final List<Widget Function(BuildContext)> _widgetOptions = <Widget Function(BuildContext)>[
    (BuildContext context) => const HomeView(),
    (BuildContext context) => const ContactsView(),
    (BuildContext context) => const Center(child: Text('My Data')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
        actions: [
          if (kDebugMode)
            IconButton(
              onPressed: () async => await GetIt.I.get<EnmeshedRuntime>().accountServices.clearAccounts(),
              icon: const Icon(Icons.clear),
            ),
          IconButton(
            onPressed: _openAccountDialog,
            icon: const Padding(padding: EdgeInsets.all(2.0), child: CircleAvatar(child: Text('AB'))),
          ),
        ],
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
      body: Builder(builder: _widgetOptions[_selectedIndex]),
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

  Future<void> _openAccountDialog() async {
    final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
    if (context.mounted) {
      await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text(AppLocalizations.of(context)!.cancel),
          children: [
            for (final account in accounts)
              SimpleDialogOption(
                child: Text(account.name),
                onPressed: () {
                  GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      );
    }
  }
}

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  List<RelationshipDTO>? _relationships;

  @override
  void initState() {
    _reload();
    super.initState();
  }

  @override
  void dispose() {
    _relationships = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_relationships == null) return const Center(child: CircularProgressIndicator());

    return RefreshIndicator(
      onRefresh: () async => await _reload(true),
      child: ListView.separated(
        itemBuilder: (context, index) => ListTile(title: Text(_relationships![index].peer)),
        itemCount: _relationships!.length,
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }

  Future<void> _reload([bool syncBefore = false]) async {
    if (syncBefore) {
      await GetIt.I.get<EnmeshedRuntime>().currentSession.transportServices.accounts.syncEverything();
    }

    final relationships = await GetIt.I.get<EnmeshedRuntime>().currentSession.transportServices.relationships.getRelationships();
    setState(() => _relationships = relationships);
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<MessageDTO>? _messages;

  @override
  void initState() {
    _reload();
    super.initState();
  }

  @override
  void dispose() {
    _messages = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_messages == null) return const Center(child: CircularProgressIndicator());

    return RefreshIndicator(
      onRefresh: () async => await _reload(true),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final content = _messages![index].content;
          return ListTile(
            title: content is Mail ? Text(content.subject) : const Text('technical message'),
            subtitle: content is Mail ? Text(content.body) : null,
          );
        },
        itemCount: _messages!.length,
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }

  Future<void> _reload([bool syncBefore = false]) async {
    if (syncBefore) {
      await GetIt.I.get<EnmeshedRuntime>().currentSession.transportServices.accounts.syncEverything();
    }

    final messages = await GetIt.I.get<EnmeshedRuntime>().currentSession.transportServices.messages.getMessages();
    setState(() => _messages = messages);
  }
}
