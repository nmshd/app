import 'package:flutter/material.dart';

class ConditionalCloseable extends StatelessWidget {
  final bool canClose;
  final Widget child;

  const ConditionalCloseable({
    required this.canClose,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canClose,
      child: GestureDetector(
        onVerticalDragStart: canClose ? null : (_) {},
        behavior: HitTestBehavior.opaque,
        child: child,
      ),
    );
  }
}
