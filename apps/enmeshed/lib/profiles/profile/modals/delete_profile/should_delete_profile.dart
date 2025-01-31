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

  const ShouldDeleteProfile({
    required this.cancel,
    required this.delete,
    required this.profileName,
    required this.otherActiveDevices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.arrow_back, size: 24), onPressed: cancel),
              Text(context.l10n.profile_delete_device, style: Theme.of(context).textTheme.titleMedium),
              IconButton(icon: const Icon(Icons.close), onPressed: cancel),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VectorGraphic(loader: AssetBytesLoader('assets/svg/confirm_profile_deletion.svg'), height: 160),
              Gaps.h24,
              Text(context.l10n.profile_delete_confirmation(profileName)),
              Gaps.h16,
              if (otherActiveDevices.isNotEmpty) ...[
                Align(alignment: Alignment.centerLeft, child: Text(context.l10n.profile_delete_confirmation_devicesLeft)),
                Gaps.h4,
                Wrap(spacing: 8, children: otherActiveDevices.map((e) => Chip(label: Text(e.name))).toList()),
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
      ],
    );
  }
}
