import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class DeviceStatusBar extends StatelessWidget {
  final String statusText;
  final bool isWarning;

  const DeviceStatusBar({required this.statusText, this.isWarning = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isWarning ? Icons.error : Icons.check_circle_outline,
          color: isWarning ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary,
          size: 24,
        ),
        Gaps.w4,
        Flexible(
          child: Text(statusText, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ),
      ],
    );
  }
}
