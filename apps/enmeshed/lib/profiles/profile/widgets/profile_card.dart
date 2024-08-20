import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class ProfileCard extends StatelessWidget {
  final LocalAccountDTO account;
  final void Function(LocalAccountDTO account) onAccountSelected;

  const ProfileCard({required this.account, required this.onAccountSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: () => onAccountSelected(account),
        selectedTileColor: Theme.of(context).colorScheme.primary,
        tileColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          account.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        leading: AutoLoadingProfilePicture(
          accountId: account.id,
          profileName: account.name,
          circleAvatarColor: context.customColors.decorativeContainer!,
        ),
      ),
    );
  }
}
