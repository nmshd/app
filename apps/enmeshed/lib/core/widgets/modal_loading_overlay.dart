import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class ModalLoadingOverlay extends StatelessWidget {
  final String text;
  final bool isDialog;

  const ModalLoadingOverlay({required this.text, required this.isDialog, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: const Radius.circular(28), bottom: isDialog ? const Radius.circular(28) : Radius.zero),
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.9),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
              Gaps.h24,
              const SizedBox(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
