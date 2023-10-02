import 'package:flutter/material.dart';

import 'pages/item_examples.dart';
import 'pages/item_examples2.dart';
import 'pages/item_group_example.dart';
import 'pages/relationship_attribute_example.dart';

main() {
  runApp(const RequestRendererExample());
}

class RequestRendererExample extends StatelessWidget {
  const RequestRendererExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Renderer',
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
    title: 'Item Examples2',
    pageBuilder: (context) => const ItemExamples2(),
  ),
  _MenuItem(
    icon: Icons.description,
    title: 'Item Group Example',
    pageBuilder: (context) => const ItemGroupExample(),
  ),
  _MenuItem(
    icon: Icons.description,
    title: 'Consent Attribute Example',
    pageBuilder: (context) => const RelationshipAttributeExample(),
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
