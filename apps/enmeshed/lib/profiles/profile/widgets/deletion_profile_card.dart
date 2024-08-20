import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';
import '../modals/restore_profile/restore_identity_modal.dart';

class DeletionProfileCard extends StatefulWidget {
  final LocalAccountDTO accountInDeletion;

  const DeletionProfileCard({required this.accountInDeletion, super.key});

  @override
  State<DeletionProfileCard> createState() => DeletionProfileCardState();
}

class DeletionProfileCardState extends State<DeletionProfileCard> {
  String? _deletionDate;

  @override
  void initState() {
    super.initState();

    _getAccountDeletionDate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.10),
        title: Text(
          widget.accountInDeletion.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          _deletionDate == null ? '' : context.l10n.identity_delete_at(DateTime.parse(_deletionDate!).toLocal()),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        leading: AutoLoadingProfilePicture(
          accountId: widget.accountInDeletion.id,
          profileName: widget.accountInDeletion.name,
          circleAvatarColor: context.customColors.decorativeContainer!,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => showRestoreIdentityModal(accountInDeletion: widget.accountInDeletion, context: context),
          tooltip: context.l10n.identity_restore,
        ),
      ),
    );
  }

  Future<void> _getAccountDeletionDate() async {
    final accountDeletionDate = await getAccountDeletionDate(widget.accountInDeletion);
    if (mounted) setState(() => _deletionDate = accountDeletionDate);
  }
}
