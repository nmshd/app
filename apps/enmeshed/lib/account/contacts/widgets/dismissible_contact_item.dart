import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/core/core.dart';

class DismissibleContactItem extends StatefulWidget {
  final String accountId;
  final IdentityDVO contact;
  final VoidCallback onTap;
  final VoidCallback onContactChanged;
  final Widget? trailing;
  final Widget? subtitle;
  final String? query;
  final int iconSize;

  const DismissibleContactItem({
    required this.accountId,
    required this.contact,
    required this.onTap,
    required this.onContactChanged,
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
              onPressed: (context) => deleteContact(
                context: context,
                accountId: widget.accountId,
                contact: widget.contact,
                onContactDeleted: widget.onContactChanged,
              ),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.error,
              icon: Icons.delete,
              spacing: 0,
            ),
          ],
        ),
        child: Container(
          decoration: !_isOpen
              ? null
              : BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.zero,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
          child: ContactItem(
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
