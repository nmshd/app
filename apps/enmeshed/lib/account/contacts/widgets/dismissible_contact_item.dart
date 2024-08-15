import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/core/core.dart';

class DismissibleContactItem extends StatefulWidget {
  final IdentityDVO contact;
  final VoidCallback onTap;
  final void Function(BuildContext) onDeletePressed;
  final Widget? trailing;
  final Widget? subtitle;
  final String? query;
  final int iconSize;

  const DismissibleContactItem({
    required this.contact,
    required this.onTap,
    required this.onDeletePressed,
    this.trailing,
    this.subtitle,
    this.query,
    this.iconSize = 56,
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
    final coloringStatus = [RelationshipStatus.Terminated, RelationshipStatus.DeletionProposed];
    final tileColor = widget.contact.relationship == null || coloringStatus.contains(widget.contact.relationship!.status)
        ? Theme.of(context).colorScheme.primaryContainer
        : null;

    return TapRegion(
      onTapOutside: (_) => _slidableController.close(),
      child: Slidable(
        controller: _slidableController,
        key: ValueKey(widget.contact.id),
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: widget.onDeletePressed,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.error,
              icon: Icons.delete_outline,
              spacing: 0,
            ),
          ],
        ),
        child: Material(
          elevation: _isOpen ? 3 : 0,
          shadowColor: Theme.of(context).colorScheme.shadow,
          child: ContactItem(
            tileColor: tileColor,
            contact: widget.contact,
            onTap: () {
              widget.onTap();
              _slidableController.close();
            },
            trailing: widget.trailing,
            subtitle: widget.subtitle,
            query: widget.query,
            iconSize: widget.iconSize,
          ),
        ),
      ),
    );
  }
}
