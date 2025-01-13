import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class ProfilesInDeletionContainer extends StatefulWidget {
  final List<LocalAccountDTO> accountsInDeletion;
  final VoidCallback onDeleted;

  const ProfilesInDeletionContainer({required this.accountsInDeletion, required this.onDeleted, super.key});

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
              onPressed: () => showRestoreIdentityModal(accountInDeletion: accountInDeletion, context: context),
              tooltip: context.l10n.identity_restore,
            ),
          ),
        DeleteDataNowCard(onDeleted: widget.onDeleted, accountsInDeletion: widget.accountsInDeletion),
      ],
    );
  }
}
