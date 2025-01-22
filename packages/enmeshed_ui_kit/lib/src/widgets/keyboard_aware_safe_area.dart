import 'dart:math' as math;

import 'package:flutter/material.dart';

class KeyboardAwareSafeArea extends StatelessWidget {
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
  final EdgeInsets minimum;
  final bool maintainBottomViewPadding;
  final Widget child;

  const KeyboardAwareSafeArea({
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      minimum: minimum.copyWith(bottom: math.max(minimum.bottom, MediaQuery.of(context).viewInsets.bottom)),
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: child,
    );
  }
}
