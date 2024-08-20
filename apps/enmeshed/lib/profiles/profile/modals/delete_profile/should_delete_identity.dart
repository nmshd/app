import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';

class ShouldDeleteIdentity extends StatelessWidget {
  final VoidCallback cancel;
  final VoidCallback delete;
  final String profileName;
  final List<DeviceDTO> devices;

  const ShouldDeleteIdentity({
    required this.cancel,
    required this.delete,
    required this.profileName,
    required this.devices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => cancel(),
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VectorGraphic(loader: AssetBytesLoader('assets/svg/confirm_identity_deletion.svg'), height: 160),
            Gaps.h24,
            Text(context.l10n.identity_delete_confirmation(profileName, devices.length)),
            Gaps.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: cancel, child: Text(context.l10n.identity_delete_cancel)),
                Gaps.w8,
                FilledButton(onPressed: delete, child: Text(context.l10n.identity_delete_confirm)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
