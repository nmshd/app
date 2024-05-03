import 'package:flutter/material.dart';

class AccountTabController extends StatelessWidget {
  const AccountTabController({
    required this.tabController,
    required this.child,
    super.key,
  });

  final TabController tabController;

  final Widget child;

  static TabController? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_TabControllerScope>()?.controller;
  }

  static TabController of(BuildContext context) {
    final controller = maybeOf(context);
    if (controller == null) {
      throw Exception(
        'AccountTabController.of() was called with a context that does not '
        'contain a AccountTabController widget.\n'
        'No AccountTabController widget ancestor could be found starting from '
        'the context that was passed to AccountTabController.of(). This can '
        'happen because you are using a widget that looks for a AccountTabController '
        'ancestor, but no such ancestor exists.\n'
        'The context used was:\n'
        '  $context',
      );
    }

    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return _TabControllerScope(
      controller: tabController,
      enabled: TickerMode.of(context),
      child: child,
    );
  }
}

class _TabControllerScope extends InheritedWidget {
  const _TabControllerScope({
    required this.controller,
    required this.enabled,
    required super.child,
  });

  final TabController controller;
  final bool enabled;

  @override
  bool updateShouldNotify(_TabControllerScope old) {
    return enabled != old.enabled || controller != old.controller;
  }
}
