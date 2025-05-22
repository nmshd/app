import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';

class ShouldDeleteProfile extends StatelessWidget {
  final VoidCallback cancel;
  final VoidCallback delete;
  final String profileName;
  final List<DeviceDTO> otherActiveDevices;

  const ShouldDeleteProfile({required this.cancel, required this.delete, required this.profileName, required this.otherActiveDevices, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomSheetHeader(title: context.l10n.profile_delete_device, onBackPressed: cancel),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VectorGraphic(loader: AssetBytesLoader('assets/svg/confirm_profile_deletion.svg'), height: 160),
              Gaps.h24,
              BoldStyledText(context.l10n.profile_delete_confirmation(profileName)),
              Gaps.h16,
              if (otherActiveDevices.isNotEmpty) ...[
                Align(alignment: Alignment.centerLeft, child: Text(context.l10n.profile_delete_confirmation_devicesLeft)),
                Gaps.h16,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    children: otherActiveDevices
                        .map(
                          (e) => Chip(
                            label: Text(e.name),
                            color: WidgetStatePropertyAll(Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.12)),
                            labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                            padding: const EdgeInsets.all(4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ] else
                Align(alignment: Alignment.centerLeft, child: Text(context.l10n.profile_delete_confirmation_lastDevice)),
              Gaps.h24,
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
      ],
    );
  }
}
