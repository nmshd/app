import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class DeleteProfileOrIdentity extends StatelessWidget {
  final VoidCallback cancel;
  final VoidCallback deleteIdentity;
  final VoidCallback deleteProfile;
  final String profileName;
  final String accountId;
  final List<DeviceDTO> onboardedDevices;

  const DeleteProfileOrIdentity({
    required this.cancel,
    required this.deleteIdentity,
    required this.deleteProfile,
    required this.profileName,
    required this.accountId,
    required this.onboardedDevices,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.l10n.profile_delete, style: Theme.of(context).textTheme.titleLarge),
              IconButton(icon: const Icon(Icons.close), onPressed: cancel),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  AutoLoadingProfilePicture(
                    accountId: accountId,
                    profileName: profileName,
                    decorative: true,
                    radius: 40,
                  ),
                  Gaps.w16,
                  Expanded(child: Text(profileName, style: Theme.of(context).textTheme.titleLarge)),
                ],
              ),
              Gaps.h24,
              Text(
                onboardedDevices.length > 1 ? context.l10n.profile_or_identity_deletion : context.l10n.profile_or_identity_deletion_oneDevice,
              ),
              Gaps.h24,
              OutlinedButton(onPressed: onboardedDevices.length > 1 ? deleteProfile : null, child: Text(context.l10n.profile_delete_device)),
              OutlinedButton.icon(
                onPressed: deleteIdentity,
                label: Text(context.l10n.profile_delete),
                icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
