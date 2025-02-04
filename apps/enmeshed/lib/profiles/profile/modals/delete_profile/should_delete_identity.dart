import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';

class ShouldDeleteIdentity extends StatelessWidget {
  final VoidCallback cancel;
  final VoidCallback delete;
  final VoidCallback deleteNow;
  final String profileName;
  final List<DeviceDTO> devices;

  const ShouldDeleteIdentity({
    required this.cancel,
    required this.delete,
    required this.deleteNow,
    required this.profileName,
    required this.devices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomSheetHeader(title: context.l10n.profile_delete, onBackPressed: cancel),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VectorGraphic(loader: AssetBytesLoader('assets/svg/confirm_identity_deletion.svg'), height: 160),
              Gaps.h24,
              BoldStyledText(context.l10n.identity_delete_confirmation(profileName, devices.where((e) => e.isOffboarded != true).length)),
              Gaps.h24,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  OutlinedButton(onPressed: cancel, child: Text(context.l10n.identity_delete_cancel)),
                  FilledButton(onPressed: delete, child: Text(context.l10n.identity_delete_confirm)),
                ],
              ),
              if (context.isFeatureEnabled('DELETE_IDENTITY_NOW')) ...[
                Gaps.h16,
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    textStyle: TextStyle(color: Theme.of(context).colorScheme.onError),
                    minimumSize: const Size.fromHeight(40),
                  ),
                  onPressed: deleteNow,
                  label: const Text('[DEBUG] Delete Forever Now'),
                  icon: const Icon(Icons.delete_forever_rounded),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
