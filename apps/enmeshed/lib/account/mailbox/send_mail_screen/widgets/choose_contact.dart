import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class ChooseContact extends StatelessWidget {
  final IdentityDVO? contact;
  final String accountId;
  final List<IdentityDVO>? relationships;
  final void Function(IdentityDVO?)? removeContact;
  final void Function(IdentityDVO) selectContact;

  const ChooseContact({
    required this.accountId,
    required this.selectContact,
    super.key,
    this.contact,
    this.relationships,
    this.removeContact,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Text(
            context.l10n.mailbox_to,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Gaps.w8,
        if (contact != null)
          _ContactChip(contact: contact!, removeContact: removeContact)
        else
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: relationships == null || relationships!.isEmpty
                ? null
                : () async {
                    final selectedContact = await showModalBottomSheet<IdentityDVO?>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => _ContactsSheet(accountId: accountId, relationships: relationships!),
                    );

                    if (selectedContact == null) return;

                    selectContact(selectedContact);
                  },
          ),
      ],
    );
  }
}

class _ContactChip extends StatelessWidget {
  final IdentityDVO contact;
  final void Function(IdentityDVO?)? removeContact;

  const _ContactChip({required this.contact, this.removeContact});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.w8,
          ContactCircleAvatar(contactName: contact.name, radius: 16),
          Gaps.w8,
          Text(contact.name, style: Theme.of(context).textTheme.labelLarge),
          if (removeContact == null) Gaps.w8,
          if (removeContact != null)
            IconButton(
              iconSize: 18,
              onPressed: () => removeContact!(null),
              icon: const Icon(Icons.cancel_outlined),
            ),
        ],
      ),
    );
  }
}

class _ContactsSheet extends StatelessWidget {
  final String accountId;
  final List<IdentityDVO> relationships;

  const _ContactsSheet({required this.accountId, required this.relationships});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height / 2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.mailbox_choose_contact, style: Theme.of(context).textTheme.titleLarge),
                IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
              ],
            ),
            Flexible(
              child: ListView.separated(
                itemCount: relationships.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => ContactItem(
                  contact: relationships[index],
                  onTap: () => context.pop(relationships[index]),
                ),
                separatorBuilder: (context, index) => ColoredBox(
                  color: Theme.of(context).colorScheme.onPrimary,
                  child: const Divider(indent: 16, endIndent: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
