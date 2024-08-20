import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class DeleteProfileOrIdentity extends StatelessWidget {
  final VoidCallback cancel;
  final VoidCallback deleteIdentity;
  final VoidCallback deleteProfile;
  final String profileName;
  final String accountId;
  final List<DeviceDTO> devices;

  const DeleteProfileOrIdentity({
    required this.cancel,
    required this.deleteIdentity,
    required this.deleteProfile,
    required this.profileName,
    required this.accountId,
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
            Row(
              children: [
                AutoLoadingProfilePicture(
                  accountId: accountId,
                  profileName: profileName,
                  circleAvatarColor: context.customColors.decorativeContainer!,
                  radius: 40,
                ),
                Gaps.w16,
                Text(profileName, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            Gaps.h24,
            Text(
              devices.length > 1 ? context.l10n.profile_or_identity_deletion : context.l10n.profile_or_identity_deletion_oneDevice,
            ),
            Gaps.h24,
            OutlinedButton(onPressed: devices.length > 1 ? deleteProfile : null, child: Text(context.l10n.profile_delete_device)),
            OutlinedButton.icon(
              onPressed: deleteIdentity,
              label: Text(context.l10n.profile_delete),
              icon: Icon(
                Icons.delete_forever_outlined,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
