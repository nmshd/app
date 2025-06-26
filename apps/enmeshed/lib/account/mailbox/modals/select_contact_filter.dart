import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

Future<IdentityDVO?> showSelectContactFilterModal({
  required List<IdentityDVO> contacts,
  required BuildContext context,
}) {
  final options = showModalBottomSheet<IdentityDVO?>(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    elevation: 0,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.75),
      child: _SelectContactFilterModal(contacts: contacts),
    ),
  );

  return options;
}

class _SelectContactFilterModal extends StatefulWidget {
  final List<IdentityDVO> contacts;

  const _SelectContactFilterModal({required this.contacts});

  @override
  _SelectContactFilterModalState createState() => _SelectContactFilterModalState();
}

class _SelectContactFilterModalState extends State<_SelectContactFilterModal> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            title: Text(
              context.l10n.mailbox_filterByContact_header,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            trailing: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.close, size: 22, color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Flexible(
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: Scrollbar(
                controller: _controller,
                thumbVisibility: true,
                interactive: true,
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.contacts.isEmpty)
                        EmptyListIndicator(icon: Icons.person, text: context.l10n.mailbox_filterByContact_noContacts)
                      else
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.contacts.length,
                          separatorBuilder: (BuildContext context, int index) => const Divider(height: 1, indent: 16),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final contact = widget.contacts[index];

                            return ContactItem(
                              contact: contact,
                              onTap: () => context.pop(contact),
                              iconSize: 42,
                            );
                          },
                        ),
                    ],
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
