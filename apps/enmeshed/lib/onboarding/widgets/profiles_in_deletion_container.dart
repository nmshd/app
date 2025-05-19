import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class ProfilesInDeletionContainer extends StatefulWidget {
  final List<LocalAccountDTO> accountsInDeletion;
  final VoidCallback onDeleted;
  final void Function(LocalAccountDTO)? onRestoredIdentity;

  const ProfilesInDeletionContainer({required this.accountsInDeletion, required this.onDeleted, this.onRestoredIdentity, super.key});

  @override
  State<ProfilesInDeletionContainer> createState() => _ProfilesInDeletionContainerState();
}

class _ProfilesInDeletionContainerState extends State<ProfilesInDeletionContainer> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        for (final accountInDeletion in widget.accountsInDeletion)
          DeletionProfileCard(
            accountInDeletion: accountInDeletion,
            trailing: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed:
                  () =>
                      showRestoreIdentityModal(accountInDeletion: accountInDeletion, context: context, onRestoredIdentity: widget.onRestoredIdentity),
              tooltip: context.l10n.identity_restore,
            ),
          ),
        ComplexInformationCard(
          title: context.l10n.profile_localDeletion_title,
          description: context.l10n.profile_localDeletion_card_description,
          icon: Icon(Icons.error, color: Theme.of(context).colorScheme.error),
          actionButtons: [
            OutlinedButton.icon(
              onPressed: () => showDeleteLocalDataModal(context: context, accountsInDeletion: widget.accountsInDeletion, onDeleted: widget.onDeleted),
              label: Text(context.l10n.profile_localDeletion_card_button),
              icon: const Icon(Icons.delete_forever_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
