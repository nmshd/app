import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'widgets/widgets.dart';

class ReloadController {
  VoidCallback? _onReload;
  set onReload(VoidCallback callback) => _onReload = callback;

  void dispose() {
    _onReload = null;
  }

  void reload() => _onReload?.call();
}

class AccountScreen extends StatefulWidget {
  final LocalAccountDTO initialAccount;

  const AccountScreen({super.key, required this.initialAccount});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _controller = ReloadController();

  late LocalAccountDTO _account;
  int _selectedIndex = 0;

  late final List<Widget Function(BuildContext)> _widgetOptions;

  @override
  void initState() {
    super.initState();

    _account = widget.initialAccount;

    _widgetOptions = <Widget Function(BuildContext)>[
      (BuildContext context) => HomeView(reloadController: _controller),
      (BuildContext context) => ContactsView(reloadController: _controller),
      (BuildContext context) => const Center(child: Text('My Data')),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
        actions: [
          IconButton(
            onPressed: _openAccountDialog,
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(child: Text(_account.name.substring(0, _account.name.length > 2 ? 2 : _account.name.length))),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            label: 'contacts',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_document),
            label: 'myData',
          ),
        ],
        onDestinationSelected: (int index) => setState(() => _selectedIndex = index),
        selectedIndex: _selectedIndex,
      ),
      body: Builder(builder: _widgetOptions[_selectedIndex]),
    );
  }

  String get _title => switch (_selectedIndex) { 0 => 'overview', 1 => 'contacts', 2 => 'myData', _ => '' };

  Future<void> _openAccountDialog() async => await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AccountDialog(
          accountsChanged: (dto) {
            _controller.reload();
            setState(() => _account = dto);
          },
          initialSelectedAccount: _account,
        ),
      );
}

class ContactsView extends StatefulWidget {
  final ReloadController reloadController;

  const ContactsView({super.key, required this.reloadController});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  List<RelationshipDTO>? _relationships;

  @override
  void initState() {
    widget.reloadController.onReload = _reload;
    _reload();
    super.initState();
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
      await GetIt.I.get<EnmeshedRuntime>().currentSession.transportServices.account.syncEverything();
    }

    final relationshipsResult = await GetIt.I.get<EnmeshedRuntime>().currentSession.transportServices.relationships.getRelationships();
    setState(() => _relationships = relationshipsResult.value);
  }
}

class HomeView extends StatefulWidget {
  final ReloadController reloadController;

  const HomeView({super.key, required this.reloadController});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<MessageDTO>? _messages;

  @override
  void initState() {
    widget.reloadController.onReload = _reload;
    _reload();
    super.initState();
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
      await GetIt.I.get<EnmeshedRuntime>().currentSession.transportServices.account.syncEverything();
    }

    final messagesResult = await GetIt.I.get<EnmeshedRuntime>().currentSession.transportServices.messages.getMessages();
    setState(() => _messages = messagesResult.value);
  }
}
