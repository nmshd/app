import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'contact_headline.dart';

class ContactsOverview extends StatelessWidget {
  final String accountId;
  final Future<void> Function() onRefresh;
  final List<IdentityDVO> relationships;
  final List<IdentityDVO> favorites;
  final void Function(IdentityDVO relationships) updateFavList;

  const ContactsOverview({
    required this.accountId,
    required this.onRefresh,
    required this.relationships,
    required this.favorites,
    required this.updateFavList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: (relationships.isEmpty)
              ? EmptyListIndicator(icon: Icons.contacts, text: context.l10n.contacts_empty, wrapInListView: true)
              : ListView.separated(
                  itemCount: relationships.length + favorites.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final contact = favorites.isEmpty ? relationships[index] : favorites[index];
                      final isFavoriteContact = favorites.any((item) => item.id == contact.id);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContactHeadline(
                            contact: favorites.isEmpty ? relationships[index] : null,
                            icon: favorites.isNotEmpty ? const Icon(Icons.star) : null,
                          ),
                          ContactItem(
                            contact: contact,
                            onTap: () => context.push('/account/$accountId/contacts/${contact.id}'),
                            trailing: IconButton(
                              icon: isFavoriteContact ? const Icon(Icons.star) : const Icon(Icons.star_border),
                              color: isFavoriteContact ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.shadow,
                              onPressed: () => updateFavList(contact),
                            ),
                          ),
                        ],
                      );
                    }

                    if (index < favorites.length) {
                      final contact = favorites[index];
                      return ContactItem(
                        contact: contact,
                        onTap: () => context.push('/account/$accountId/contacts/${contact.id}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.star),
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () => updateFavList(contact),
                        ),
                      );
                    }

                    final contact = relationships[index - favorites.length];
                    final isFavoriteContact = favorites.any((item) => item.id == contact.id);

                    return ContactItem(
                      contact: contact,
                      onTap: () => context.push('/account/$accountId/contacts/${contact.id}'),
                      trailing: IconButton(
                        icon: isFavoriteContact ? const Icon(Icons.star) : const Icon(Icons.star_border),
                        color: isFavoriteContact ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.shadow,
                        onPressed: () => updateFavList(contact),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    if (index - (favorites.length - 1) == 0) {
                      return ContactHeadline(contact: relationships[0]);
                    }

                    if (index >= favorites.length &&
                        relationships[index - favorites.length].initials[0].toLowerCase() !=
                            relationships[index - favorites.length + 1].initials[0].toLowerCase()) {
                      return ContactHeadline(contact: relationships[index - favorites.length + 1]);
                    }

                    return ColoredBox(
                      color: Theme.of(context).colorScheme.onPrimary,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
