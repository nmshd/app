import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class DeleteProfileOrIdentity extends StatelessWidget {
  final VoidCallback deleteIdentity;
  final VoidCallback deleteProfile;
  final String profileName;
  final String accountId;
  final List<DeviceDTO> otherActiveDevices;

  const DeleteProfileOrIdentity({
    required this.deleteIdentity,
    required this.deleteProfile,
    required this.profileName,
    required this.accountId,
    required this.otherActiveDevices,
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
              IconButton(icon: const Icon(Icons.close), onPressed: context.pop),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(4)),
                child: Column(
                  children: [
                    Align(
                      child: AutoLoadingProfilePicture(
                        accountId: accountId,
                        profileName: profileName,
                        decorative: true,
                        radius: 60,
                      ),
                    ),
                    Gaps.h16,
                    Text(profileName, style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
              Gaps.h32,
              Text(
                otherActiveDevices.isNotEmpty ? context.l10n.profile_or_identity_deletion : context.l10n.profile_or_identity_deletion_oneDevice,
              ),
              Gaps.h32,
              OutlinedButton(
                style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
                onPressed: otherActiveDevices.isNotEmpty ? deleteProfile : null,
                child: Text(context.l10n.profile_delete_device),
              ),
              Gaps.h8,
              OutlinedButton(
                style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
                onPressed: deleteIdentity,
                child: Text(context.l10n.profile_delete),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
