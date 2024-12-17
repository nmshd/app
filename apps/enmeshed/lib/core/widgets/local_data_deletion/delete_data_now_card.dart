import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../modals/modals.dart';
import '../../utils/utils.dart';

class DeleteDataNowCard extends StatelessWidget {
  final List<LocalAccountDTO> accountsInDeletion;
  final VoidCallback onDeleted;

  const DeleteDataNowCard({super.key, required this.accountsInDeletion, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.error, color: Theme.of(context).colorScheme.error),
                Gaps.w8,
                Expanded(child: Text(context.l10n.profile_localDeletion_title, style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(context.l10n.profile_localDeletion_card_description, style: Theme.of(context).textTheme.bodySmall),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: OutlinedButton.icon(
              onPressed: () => showDeleteLocalDataModal(context: context, accountsInDeletion: accountsInDeletion, onDeleted: onDeleted),
              label: Text(context.l10n.profile_localDeletion_card_button),
              icon: Icon(Icons.delete_forever_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
