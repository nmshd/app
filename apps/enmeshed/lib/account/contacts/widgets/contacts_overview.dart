import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'contact_favorite.dart';
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
    if (relationships.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: EmptyListIndicator(
          icon: Icons.contacts,
          text: context.l10n.contacts_empty,
          description: context.l10n.contacts_emptyDescription,
          wrapInListView: true,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: [
          if (favorites.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ContactHeadline(icon: favorites.isNotEmpty ? const Icon(Icons.star) : null),
              ),
            ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ContactFavorite(
                  contact: favorites[index],
                  onTap: () => context.push('/account/$accountId/contacts/${favorites[index].id}'),
                );
              },
              childCount: favorites.length,
            ),
          ),
          SliverList.separated(
            itemCount: relationships.length,
            itemBuilder: (context, index) {
              final contact = relationships[index];
              final isFavoriteContact = favorites.any((item) => item.id == contact.id);

              return Column(
                children: [
                  if (index == 0) ContactHeadline(contact: relationships[0]),
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
            },
            separatorBuilder: (context, index) {
              if (index < relationships.length &&
                  relationships[index].initials[0].toLowerCase() != relationships[index + 1].initials[0].toLowerCase()) {
                return ContactHeadline(contact: relationships[index + 1]);
              }

              return const Divider(indent: 16);
            },
          ),
        ],
      ),
    );
  }
}
