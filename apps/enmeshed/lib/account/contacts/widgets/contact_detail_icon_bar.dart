import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../modals/modals.dart';

class ContactDetailIconBar extends StatefulWidget {
  final Session session;
  final String accountId;
  final IdentityDVO contact;
  final bool? isFavoriteContact;
  final Future<void> Function() reloadContact;

  const ContactDetailIconBar({
    required this.session,
    required this.accountId,
    required this.contact,
    required this.isFavoriteContact,
    required this.reloadContact,
    super.key,
  });

  @override
  State<ContactDetailIconBar> createState() => _ContactDetailIconBarState();
}

class _ContactDetailIconBarState extends State<ContactDetailIconBar> {
  bool _loadingFavoriteContact = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        children: [
          if (_loadingFavoriteContact)
            const IconButton(onPressed: null, icon: SizedBox(width: 24, height: 24, child: CircularProgressIndicator()))
          else
            IconButton(
              icon: widget.isFavoriteContact ?? false ? const Icon(Icons.star) : const Icon(Icons.star_border),
              color: widget.isFavoriteContact ?? false ? Theme.of(context).colorScheme.primary : null,
              onPressed: widget.isFavoriteContact == null ? null : _toggleFavoriteContact,
              tooltip: switch (widget.isFavoriteContact) {
                true => context.l10n.contactDetail_removeFromFavorites,
                false => context.l10n.contactDetail_addToFavorites,
                null => null,
              },
            ),
          IconButton(onPressed: _renameContact, icon: const Icon(Icons.edit_outlined), tooltip: context.l10n.contactDetail_editContact),
          if (widget.contact.relationship?.status == RelationshipStatus.Active && widget.contact.relationship?.sendMailDisabled == false)
            IconButton(
              onPressed: () => context.push('/account/${widget.accountId}/mailbox/send', extra: widget.contact),
              icon: const Icon(Icons.mail_outlined),
              tooltip: context.l10n.contactDetail_sendMessage,
            ),
          IconButton(
            onPressed: () => deleteContact(
              context: context,
              accountId: widget.accountId,
              contact: widget.contact,
              onContactDeleted: () {
                if (context.mounted) context.pop();
              },
            ),
            icon: const Icon(Icons.delete_outline),
            tooltip: context.l10n.contacts_delete_deleteContact,
          ),
        ],
      ),
    );
  }

  Future<void> _renameContact() async {
    var newName = await showRenameContactModal(context: context, contact: widget.contact);
    if (newName == null) return;

    if (newName == widget.contact.name) return;
    if (newName == widget.contact.originalName) newName = null;

    await setContactName(relationshipId: widget.contact.relationship!.id, session: widget.session, accountId: widget.accountId, contactName: newName);
    await widget.reloadContact();

    if (mounted) showSuccessSnackbar(context: context, text: context.l10n.contactDetail_editContact_displayNameChangedMessage);
  }

  Future<void> _toggleFavoriteContact() async {
    setState(() => _loadingFavoriteContact = true);

    await toggleContactPinned(relationshipId: widget.contact.relationship!.id, session: GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId));

    await widget.reloadContact();

    setState(() => _loadingFavoriteContact = false);
  }
}
