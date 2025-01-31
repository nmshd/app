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
    if (canClose) return child;

    return PopScope(
      canPop: false,
      child: GestureDetector(
        onVerticalDragStart: (_) {},
        behavior: HitTestBehavior.opaque,
        child: child,
      ),
    );
  }
}
