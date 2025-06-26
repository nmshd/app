import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/core/core.dart';

class DismissibleContactItem extends StatefulWidget {
  final IdentityWithOpenRequests item;
  final VoidCallback onTap;
  final void Function(BuildContext) onDeletePressed;
  final bool isFavoriteContact;
  final VoidCallback onToggleFavorite;
  final Widget? trailing;
  final String? query;

  const DismissibleContactItem({
    required this.item,
    required this.onTap,
    required this.onDeletePressed,
    required this.isFavoriteContact,
    required this.onToggleFavorite,
    this.trailing,
    this.query,
    super.key,
  });

  @override
  State<DismissibleContactItem> createState() => _DismissibleContactItemState();
}

class _DismissibleContactItemState extends State<DismissibleContactItem> with SingleTickerProviderStateMixin {
  late final SlidableController _slidableController;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();

    _slidableController = SlidableController(this)
      ..actionPaneType.addListener(() {
        final isOpen = _slidableController.actionPaneType.value == ActionPaneType.end;
        setState(() => _isOpen = isOpen);
      });
  }

  @override
  void dispose() {
    _slidableController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (_) => _slidableController.close(),
      child: Slidable(
        controller: _slidableController,
        key: ValueKey(widget.item.contact.id),
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: widget.onDeletePressed,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
              icon: Icons.delete_outline,
              spacing: 0,
            ),
          ],
        ),
        child: Material(
          elevation: _isOpen ? 3 : 0,
          shadowColor: Theme.of(context).colorScheme.shadow,
          child: ContactItem(
            contact: widget.item.contact,
            openContactRequest: widget.item.openRequests.firstOrNull,
            onTap: () {
              widget.onTap();
              _slidableController.close();
            },
            trailing:
                widget.trailing ??
                _TrailingIcon(
                  item: widget.item,
                  isFavoriteContact: widget.isFavoriteContact,
                  onToggleFavorite: widget.onToggleFavorite,
                  onDeletePressed: () => widget.onDeletePressed(context),
                ),
            subtitle:
                widget.item.contact.relationship?.status == RelationshipStatus.Active && widget.item.contact.relationship?.peerDeletionStatus == null
                ? null
                : _Subtitle(item: widget.item),
            query: widget.query,
            iconSize: 40,
          ),
        ),
      ),
    );
  }
}

class _TrailingIcon extends StatelessWidget {
  final bool isFavoriteContact;
  final VoidCallback onDeletePressed;
  final VoidCallback onToggleFavorite;
  final IdentityWithOpenRequests item;

  const _TrailingIcon({required this.isFavoriteContact, required this.onDeletePressed, required this.onToggleFavorite, required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.openRequests.firstOrNull?.status == LocalRequestStatus.Expired) {
      return IconButton(icon: const Icon(Icons.cancel_outlined), onPressed: onDeletePressed);
    }

    if (!item.contact.hasRelationship) return const Padding(padding: EdgeInsets.all(8), child: Icon(Icons.edit));

    return IconButton(
      icon: isFavoriteContact ? const Icon(Icons.star) : const Icon(Icons.star_border),
      color: isFavoriteContact ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
      onPressed: onToggleFavorite,
    );
  }
}

class _Subtitle extends StatelessWidget {
  final IdentityWithOpenRequests item;

  const _Subtitle({required this.item});

  @override
  Widget build(BuildContext context) {
    final expiresAt = item.openRequests.firstOrNull?.content.expiresAt;
    final isExpiringRequest = item.openRequests.firstOrNull?.status != LocalRequestStatus.Expired && expiresAt != null;

    if (isExpiringRequest && DateTime.parse(expiresAt).isBefore(DateTime.now().add(const Duration(days: 7)))) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: ContactStatusText(
              contact: item.contact,
              openContactRequest: item.openRequests.firstOrNull,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Gaps.h4,
          Text(
            context.l10n.contacts_requestWithExpiryDate(DateTime.parse(expiresAt).toLocal()),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ],
      );
    }

    return ContactStatusText(
      contact: item.contact,
      openContactRequest: item.openRequests.firstOrNull,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}
