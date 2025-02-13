import 'package:flutter/material.dart';

import 'drawer_hints_page.dart';
import 'drawer_main_page.dart';
import 'drawer_notifications_page.dart';

class AppDrawer extends StatefulWidget {
  final String accountId;

  const AppDrawer({required this.accountId, super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late Widget _currentPage = DrawerMainPage(goToNotifications: _goToNotifications, goToHints: _goToHints);

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width * 0.85;

    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        width: maxWidth,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder:
                (child, animation) => SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: child is DrawerMainPage ? const Offset(-1, 0) : const Offset(1, 0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeInOut)),
                  ),
                  child: child,
                ),
            child: _currentPage,
          ),
        ),
      ),
    );
  }

  void _goHome() => setState(() => _currentPage = DrawerMainPage(goToNotifications: _goToNotifications, goToHints: _goToHints));
  void _goToNotifications() => setState(() => _currentPage = DrawerNotificationsPage(goBack: _goHome));
  void _goToHints() => setState(() => _currentPage = DrawerHintsPage(goBack: _goHome, accountId: widget.accountId));
}
