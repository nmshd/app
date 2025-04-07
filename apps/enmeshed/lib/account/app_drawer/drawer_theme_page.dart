import 'package:flutter/material.dart';

class DrawerThemePage extends StatefulWidget {
  final VoidCallback goBack;

  const DrawerThemePage({required this.goBack, super.key});

  @override
  State<DrawerThemePage> createState() => _DrawerThemePageState();
}

class _DrawerThemePageState extends State<DrawerThemePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
