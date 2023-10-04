import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/create_attribute_request_item_example/identity_attribute_example.dart';
import 'pages/create_attribute_request_item_example/rejected_create_attribute_request_json_example.dart';
import 'pages/create_attribute_request_item_example/relationship_attribute_example.dart';
import 'pages/item_examples.dart';
import 'pages/item_group_example.dart';
import 'pages/read_attribute_request_item_example.dart';

main() {
  runApp(const RequestRendererExample());
}

class RequestRendererExample extends StatelessWidget {
  const RequestRendererExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Renderer',
      localizationsDelegates: [
        FlutterI18nDelegate(translationLoader: FileTranslationLoader(basePath: 'assets/i18n')),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _MenuItem _selectedMenuItem = _menu[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selectedMenuItem.title)),
      drawer: SafeArea(
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
            child: ListView(
              children: [
                for (final item in _menu)
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
            ),
          ),
        ),
      ),
      body: _selectedMenuItem.pageBuilder(context),
    );
  }
}

final _menu = [
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
    title: 'Create JSON Example',
    pageBuilder: (context) => const RejectedCreateAttributeRequestJsonExample(),
  ),
  _MenuItem(
    icon: Icons.description,
    title: 'Read Attribute Request Item Example',
    pageBuilder: (context) => const ReadAttributeRequestItemExample(),
  ),
];

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

class _DrawerButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const _DrawerButton({
    Key? key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    required this.onPressed,
  }) : super(key: key);

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
