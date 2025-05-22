import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'contact_header.dart';

class ChooseContact extends StatelessWidget {
  final String accountId;
  final void Function(IdentityDVO?) selectContact;
  final bool showRemoveContact;

  final IdentityDVO? contact;
  final List<IdentityDVO>? relationships;

  const ChooseContact({
    required this.accountId,
    required this.selectContact,
    required this.showRemoveContact,
    this.contact,
    this.relationships,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () => _onSelectPressed(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: contact != null ? ContactHeader(contact: contact!) : Text(context.l10n.mailbox_to, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
    );
  }

  Future<void> _onSelectPressed(BuildContext context) async {
    final selectedContact = await showModalBottomSheet<IdentityDVO?>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ContactsSheet(accountId: accountId, relationships: relationships!),
    );

    if (selectedContact == null) return;

    selectContact(selectedContact);
  }
}

class _ContactsSheet extends StatelessWidget {
  final String accountId;
  final List<IdentityDVO> relationships;

  const _ContactsSheet({required this.accountId, required this.relationships});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height / 1.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(title: context.l10n.mailbox_choose_contact),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(context.l10n.mailbox_choose_contact_description, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(
                    children: relationships
                        .map((contact) {
                          final enabled = contact.relationship?.sendMailDisabled == false;

                          return ContactItem(
                            enabled: enabled,
                            contact: contact,
                            onTap: () => context.pop(contact),
                            subtitle: enabled ? null : Text(context.l10n.mailbox_choose_contact_sendMailDenied),
                          );
                        })
                        .separated(() => const Divider(indent: 16, height: 1)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
