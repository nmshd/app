import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class DeviceOnboardingSuccess extends StatelessWidget {
  const DeviceOnboardingSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.h40,
          Icon(Icons.check_circle_rounded, size: 160, color: context.customColors.success),
          Gaps.h24,
          Text(context.l10n.devices_otherDeviceOnboardedSuccess, style: Theme.of(context).textTheme.bodyMedium),
          Gaps.h40,
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () => context.pop(),
              child: Text(context.l10n.devices_onboardingSuccessButton),
            ),
          ),
        ],
      ),
    );
  }
}
