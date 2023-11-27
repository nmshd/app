import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'account_requests/requests_screen.dart';
import 'create_attribute_request_item_example/identity_attribute_example.dart';
import 'create_attribute_request_item_example/rejected_create_attribute_request_json_example.dart';
import 'create_attribute_request_item_example/relationship_attribute_example.dart';
import 'decidable_examples/decidable_consent_request_item_example.dart';
import 'decidable_examples/decidable_create_request_item_example.dart';
import 'decidable_examples/decidable_create_request_relationship_item_example.dart';
import 'decidable_examples/decidable_propose_request_item_example.dart';
import 'decidable_examples/decidable_propose_request_relationship_item_example.dart';
import 'decidable_examples/decidable_read_request_item_example.dart';
import 'decidable_examples/decidable_read_request_relationship_item_example.dart';
import 'decidable_examples/decidable_register_request_item_example.dart';
import 'item_examples.dart';
import 'item_group_example.dart';
import 'read_attribute_request_item_example.dart';
import 'requests_example.dart';
import 'response_examples/error_response_item_example.dart';
import 'response_examples/response_item_example.dart';
import 'widgets/widgets.dart';

class ReloadController {
  VoidCallback? _onReload;
  set onReload(VoidCallback callback) => _onReload = callback;

  void dispose() {
    _onReload = null;
  }

  void reload() => _onReload?.call();
}

class HomeScreen extends StatefulWidget {
  final LocalAccountDTO initialAccount;

  const HomeScreen({super.key, required this.initialAccount});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LocalAccountDTO _account;
  List<_MenuGroup> menu = [];
  late _MenuItem _selectedMenuItem;

  @override
  void initState() {
    super.initState();

    _account = widget.initialAccount;

    menu = <_MenuGroup>[
      _MenuGroup(
        items: [
          _MenuItem(
            icon: Icons.description,
            title: 'Request Items JSON Example',
            pageBuilder: (context) => const RequestsExample(),
          ),
          _MenuItem(
            icon: Icons.description,
            title: 'Item Examples',
            pageBuilder: (context) => const ItemExamples(),
          ),
          _MenuItem(
            icon: Icons.description,
            title: 'Item Group Example',
            pageBuilder: (context) => const ItemGroupExample(),
          ),
          _MenuItem(
            icon: Icons.description,
            title: 'Read Attribute Request Item Example',
            pageBuilder: (context) => const ReadAttributeRequestItemExample(),
          ),
          _MenuItem(
            icon: Icons.description,
            title: 'Account Example',
            pageBuilder: (context) => RequestsScreen(
              accountId: _account.id,
              //reloadController: _reloadController,
            ),
          ),
        ],
      ),
      _MenuGroup(title: 'Create Attribute', items: [
        _MenuItem(
          icon: Icons.description,
          title: 'Create Relationship Attribute Example',
          pageBuilder: (context) => const RelationshipAttributeExample(),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Create Identity Attribute Example',
          pageBuilder: (context) => const IdentityAttributeExample(),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Rejected Create Attribute Request JSON Example',
          pageBuilder: (context) => const RejectedCreateAttributeRequestJsonExample(),
        ),
      ]),
      _MenuGroup(title: 'Decidable Requests', items: [
        _MenuItem(
          icon: Icons.description,
          title: 'Decidable Consent Request',
          pageBuilder: (context) => const DecidableConsentRequestItemExample(),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Decidable Register Request',
          pageBuilder: (context) => const DecidableRegisterRequestItemExample(),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Decidable Read Identity Attribute with results Example',
          pageBuilder: (context) => const DecidableReadRequestItemExample(isWithResults: true),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Decidable Read Identity Attribute without results Example',
          pageBuilder: (context) => const DecidableReadRequestItemExample(isWithResults: false),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Decidable Read Relationship Attribute with results Example',
          pageBuilder: (context) => const DecidableReadRequestRelationshipItemExample(isWithResults: true),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Decidable Propose Identity Attribute Example',
          pageBuilder: (context) => const DecidableProposeRequestItemExample(),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Decidable Propose Relationship Attribute Example',
          pageBuilder: (context) => const DecidableProposeRequestRelationshipItemExample(),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Decidable Create Identity Attribute Example',
          pageBuilder: (context) => const DecidableCreateRequestItemExample(),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Decidable Create Relationship Attribute Example',
          pageBuilder: (context) => const DecidableCreateRequestRelationshipItemExample(),
        ),
      ]),
      _MenuGroup(title: 'Response Requests', items: [
        _MenuItem(
          icon: Icons.description,
          title: 'Error Response Renderer',
          pageBuilder: (context) => const ErrorResponseItemExample(),
        ),
        _MenuItem(
          icon: Icons.description,
          title: 'Response Renderer',
          pageBuilder: (context) => const ResponseItemExample(),
        ),
      ])
    ];

    _selectedMenuItem = menu[0].items[0];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_selectedMenuItem.title),
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
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
          child: ListView(
            children: [
              for (final group in menu) ...[
                if (group.title != null) _DrawerHeader(title: group.title),
                for (final item in group.items)
                  _DrawerButton(
                    icon: item.icon,
                    title: item.title,
                    isSelected: item == _selectedMenuItem,
                    onPressed: () {
                      setState(() {
                        _selectedMenuItem = item;
                      });

                      if (mounted) Navigator.of(context).pop();
                    },
                  ),
                const SizedBox(height: 24),
              ],
            ],
          ),
        ),
      ),
      body: _selectedMenuItem.pageBuilder(context),
    );
  }

  Future<void> _openAccountDialog() async => await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AccountDialog(
          accountsChanged: (dto) {
            setState(() => _account = dto);
          },
          initialSelectedAccount: _account,
        ),
      );
}

class _MenuGroup {
  const _MenuGroup({this.title, required this.items});

  final String? title;
  final List<_MenuItem> items;
}

class _MenuItem {
  final IconData icon;
  final String title;
  final Widget Function(BuildContext context) pageBuilder;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.pageBuilder,
  });
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({required this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Text(title!, style: const TextStyle(color: Color(0xFF444444), fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const _DrawerButton({
    required this.icon,
    required this.title,
    this.isSelected = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) {
              if (isSelected) return const Color(0xFFBBBBBB);

              if (states.contains(MaterialState.hovered)) return Colors.grey.withOpacity(0.1);

              return Colors.transparent;
            }),
            foregroundColor: MaterialStateColor.resolveWith((states) => isSelected ? Colors.white : const Color(0xFFBBBBBB)),
            elevation: MaterialStateProperty.resolveWith((states) => 0),
            padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.all(16))),
        onPressed: isSelected ? null : onPressed,
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(icon),
            const SizedBox(width: 16),
            Expanded(child: Text(title)),
          ],
        ),
      ),
    );
  }
}
