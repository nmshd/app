import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '/core/core.dart';

class SelectProfileDialog extends StatefulWidget {
  final List<LocalAccountDTO> possibleAccounts;
  final String? title;
  final String? description;

  const SelectProfileDialog({required this.possibleAccounts, super.key, this.title, this.description});

  @override
  State<SelectProfileDialog> createState() => _SelectProfileDialogState();
}

class _SelectProfileDialogState extends State<SelectProfileDialog> {
  bool _chooseExisting = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: _chooseExisting && widget.possibleAccounts.isNotEmpty
            ? _ChooseExistingProfile(
                possibleAccounts: widget.possibleAccounts,
                title: widget.title,
                description: widget.description,
                createNewProfilePressed: () => setState(() => _chooseExisting = false),
              )
            : CreateProfile(
                onProfileCreated: (account) => context.pop(account),
                onBackPressed: widget.possibleAccounts.isEmpty ? null : () => setState(() => _chooseExisting = true),
                description: context.l10n.profiles_createNewForProcessingQrDescription,
                isInDialog: true,
              ),
      ),
    );
  }
}

class _ChooseExistingProfile extends StatelessWidget {
  final List<LocalAccountDTO> possibleAccounts;
  final String? title;
  final String? description;

  final VoidCallback createNewProfilePressed;

  const _ChooseExistingProfile({required this.possibleAccounts, required this.createNewProfilePressed, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    final sorted = possibleAccounts..sort((b, a) => (a.lastAccessedAt ?? '').compareTo(b.lastAccessedAt ?? ''));

    final active = sorted.first;
    final otherAccounts = sorted.skip(1).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TranslatedText(title ?? 'i18n://uibridge.accountSelection.title', style: Theme.of(context).textTheme.headlineSmall),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TranslatedText(description ?? 'i18n://uibridge.accountSelection.description'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _ProfileListTile(localAccountDTO: active, isActiveAccount: true),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8).copyWith(left: 24, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.profiles_otherProfiles, style: Theme.of(context).textTheme.titleMedium),
                IconButton.filledTonal(
                  onPressed: createNewProfilePressed,
                  icon: Icon(Icons.add, size: 16, color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          Flexible(
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: ListView.separated(
                  itemBuilder: (context, index) => _ProfileListTile(localAccountDTO: otherAccounts[index]),
                  separatorBuilder: (_, __) => Divider(indent: 16, endIndent: 16, height: 1, color: Theme.of(context).colorScheme.outline),
                  itemCount: otherAccounts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
              ),
            ),
          ),
          Gaps.h16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
          ),
        ],
      ),
    );
  }
}

class _ProfileListTile extends StatelessWidget {
  final LocalAccountDTO localAccountDTO;
  final bool isActiveAccount;

  const _ProfileListTile({required this.localAccountDTO, this.isActiveAccount = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: AutoLoadingProfilePicture(accountId: localAccountDTO.id, profileName: localAccountDTO.name, decorative: true),
      title: Text(localAccountDTO.name),
      subtitle: isActiveAccount ? Text(context.l10n.profiles_lastUsed) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.pop(localAccountDTO),
    );
  }
}
