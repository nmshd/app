import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class DeletionProfileCard extends StatelessWidget {
  final LocalAccountDTO accountInDeletion;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const DeletionProfileCard({
    required this.accountInDeletion,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profilePicture = AutoLoadingProfilePicture(
      accountId: accountInDeletion.id,
      profileName: accountInDeletion.name,
      circleAvatarColor: context.customColors.decorativeContainer,
    );

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.errorContainer,
        onTap: onTap,
        title: Text(
          accountInDeletion.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onErrorContainer),
        ),
        subtitle: Text(
          accountInDeletion.deletionDate == null ? '' : context.l10n.identity_delete_at(DateTime.parse(accountInDeletion.deletionDate!).toLocal()),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        leading: leading == null ? profilePicture : Row(mainAxisSize: MainAxisSize.min, children: [leading!, profilePicture]),
        trailing: trailing,
      ),
    );
  }
}
