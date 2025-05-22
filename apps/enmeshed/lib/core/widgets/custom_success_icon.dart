import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class CustomSuccessIcon extends StatelessWidget {
  final double containerSize;
  final double iconSize;

  const CustomSuccessIcon({required this.containerSize, required this.iconSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(color: context.customColors.success, shape: BoxShape.circle),
      child: Center(
        child: Icon(Icons.check, color: context.customColors.onSuccess, size: iconSize),
      ),
    );
  }
}
