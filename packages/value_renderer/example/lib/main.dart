import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/controller_example.dart';
import 'pages/input_examples.dart';
import 'pages/renderer.dart';

main() {
  runApp(const ValueRendererExample());
}

class ValueRendererExample extends StatelessWidget {
  const ValueRendererExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Value Renderer',
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(basePath: 'assets/i18n'),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      theme: ThemeData(primarySwatch: Colors.blue),
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
  _MenuItem? _selectedMenuItem;

  @override
  void initState() {
    super.initState();
    _selectedMenuItem = _menu[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selectedMenuItem!.title)),
      key: GlobalKey<ScaffoldState>(),
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
    );
  }
}

final _menu = [
  _MenuItem(
    icon: Icons.description,
    title: 'Input Examples',
    pageBuilder: (context) => const InputExamples(),
  ),
  _MenuItem(
    icon: Icons.description,
    title: 'Renderer',
    pageBuilder: (context) => const Renderer(),
  ),
  _MenuItem(
    icon: Icons.description,
    title: 'Controller Exaple',
    pageBuilder: (context) => const ControllerExample(),
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
