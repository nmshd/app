import 'dart:math';

import 'package:enmeshed_types/enmeshed_types.dart';
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
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.mailbox_choose_contact, style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              context.l10n.mailbox_choose_contact_description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(bottom: max(MediaQuery.paddingOf(context).bottom, 16)),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(
                    children: relationships
                        .map((contact) => ContactItem(contact: contact, onTap: () => context.pop(contact)))
                        .separated(() => const Divider(indent: 16)),
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
