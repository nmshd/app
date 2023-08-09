import 'package:example/pages/input_examples.dart';
import 'package:example/pages/renderer.dart';
import 'package:flutter/material.dart';

main() {
  runApp(const ValueRendererExample());
}

class ValueRendererExample extends StatelessWidget {
  const ValueRendererExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Value Renderer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _MenuItem? _selectedMenuItem;

  @override
  void initState() {
    super.initState();

    _selectedMenuItem = _menu[0].items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selectedMenuItem!.title)),
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      body: _selectedMenuItem!.pageBuilder(context),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final group in _menu) ...[
                  if (group.title != null) _DrawerHeader(title: group.title),
                  for (final item in group.items) ...[
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
                  ],
                  const SizedBox(height: 24),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final _menu = <_MenuGroup>[
  _MenuGroup(title: 'Value Renderer Examples', items: [
    _MenuItem(
      icon: Icons.description,
      title: 'Input Examples',
      pageBuilder: (context) {
        return const InputExamples();
      },
    ),
    _MenuItem(
      icon: Icons.description,
      title: 'Renderer',
      pageBuilder: (context) {
        return const Renderer();
      },
    ),
  ])
];

class _MenuGroup {
  const _MenuGroup({
    this.title,
    required this.items,
  });

  final String? title;
  final List<_MenuItem> items;
}

class _MenuItem {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.pageBuilder,
  });

  final IconData icon;
  final String title;
  final Widget Function(BuildContext context) pageBuilder;
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Text(
        title!,
        style: const TextStyle(
          color: Color(0xFF444444),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({
    Key? key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) {
              if (isSelected) {
                return const Color(0xFFBBBBBB);
              }
              if (states.contains(MaterialState.hovered)) {
                return Colors.grey.withOpacity(0.1);
              }
              return Colors.transparent;
            }),
            foregroundColor: MaterialStateColor.resolveWith((states) => isSelected ? Colors.white : const Color(0xFFBBBBBB)),
            elevation: MaterialStateProperty.resolveWith((states) => 0),
            padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.all(16))),
        onPressed: isSelected ? null : onPressed,
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(
              icon,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}
