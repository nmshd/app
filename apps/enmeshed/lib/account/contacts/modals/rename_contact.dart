import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

Future<String?> showRenameContactModal({required IdentityDVO contact, required BuildContext context}) {
  final options = showModalBottomSheet<String?>(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    builder: (context) => _RenameContactModal(contact: contact),
  );

  return options;
}

class _RenameContactModal extends StatefulWidget {
  final IdentityDVO contact;

  const _RenameContactModal({required this.contact});

  @override
  State<_RenameContactModal> createState() => _RenameContactModalState();
}

class _RenameContactModalState extends State<_RenameContactModal> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.contact.name == unknownContactName ? '' : widget.contact.name);
    _focusNode.requestFocus();

    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  String get hintText {
    final hintText = widget.contact.originalName ?? widget.contact.name;
    if (hintText == unknownContactName) return context.l10n.contacts_unknown;

    return hintText;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 24, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.contactDetail_editContact, style: Theme.of(context).textTheme.titleLarge),
                IconButton(onPressed: context.pop, icon: const Icon(Icons.close)),
              ],
            ),
          ),
          Gaps.h16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: context.l10n.contactDetail_editContact_displayName,
                hintText: hintText,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Gaps.h16,
          Align(
            child: OutlinedButton(
              onPressed: _controller.text == (widget.contact.originalName ?? widget.contact.name) ? null : _onReset,
              child: Text(context.l10n.contactDetail_editContact_restoreDefault),
            ),
          ),
          Gaps.h24,
          Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), child: Text(context.l10n.contactDetail_editContact_description)),
          Gaps.h24,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: context.pop, child: Text(context.l10n.cancel)),
                Gaps.w8,
                FilledButton(onPressed: _onSave, child: Text(context.l10n.save)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onReset() {
    final defaultName = widget.contact.originalName ?? widget.contact.name;
    if (defaultName == unknownContactName) return _controller.clear();

    _controller.text = defaultName;
  }

  void _onSave() {
    final newName = switch (_controller.text.trim()) {
      '' => widget.contact.originalName ?? widget.contact.name,
      final String name => name,
    };

    context.pop(newName);
  }
}
