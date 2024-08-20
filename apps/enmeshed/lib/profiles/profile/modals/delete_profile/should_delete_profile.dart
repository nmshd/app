import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';

class ShouldDeleteProfile extends StatelessWidget {
  final VoidCallback cancel;
  final VoidCallback delete;
  final String profileName;
  final List<DeviceDTO> devices;

  const ShouldDeleteProfile({
    required this.cancel,
    required this.delete,
    required this.profileName,
    required this.devices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final onboardedDevices = devices
        .where(
          (element) => element.isOnboarded && element.isOffboarded != true && !element.isCurrentDevice,
        )
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => cancel(),
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VectorGraphic(loader: AssetBytesLoader('assets/svg/confirm_profile_deletion.svg'), height: 160),
            Gaps.h24,
            Text(context.l10n.profile_delete_confirmation(profileName)),
            Gaps.h16,
            if (onboardedDevices.isNotEmpty) ...[
              Align(alignment: Alignment.centerLeft, child: Text(context.l10n.profile_delete_confirmation_devicesLeft)),
              Gaps.h4,
              Wrap(spacing: 8, children: onboardedDevices.map((e) => Chip(label: Text(e.name))).toList()),
            ] else
              Align(alignment: Alignment.centerLeft, child: Text(context.l10n.profile_delete_confirmation_lastDevice)),
            Gaps.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: cancel, child: Text(context.l10n.profile_delete_cancel)),
                Gaps.w8,
                FilledButton(onPressed: delete, child: Text(context.l10n.profile_delete_confirm)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
