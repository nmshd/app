import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import 'widgets/send_mail_widgets.dart';

class SendMailScreen extends StatefulWidget {
  final String accountId;
  final IdentityDVO? contact;

  const SendMailScreen({required this.accountId, super.key, this.contact});

  @override
  State<SendMailScreen> createState() => _SendMailScreenState();
}

class _SendMailScreenState extends State<SendMailScreen> {
  IdentityDVO? _recipient;
  List<IdentityDVO>? _relationships;
  final List<FileDVO> _attachments = [];
  bool _sendingMail = false;

  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  final _subjectFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _subjectFocusNode.addListener(() => setState(() {}));
    _messageFocusNode.addListener(() => setState(() {}));

    _subjectController.addListener(() => setState(() {}));
    _messageController.addListener(() => setState(() {}));

    _loadContacts();
    _recipient = widget.contact;
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();

    _subjectFocusNode.dispose();
    _messageFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_relationships == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.mailbox_new_message),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.mailbox_new_message),
        actions: [
          IconButton(icon: const Icon(Icons.send), onPressed: _canSendMail && !_sendingMail ? _sendMessage : null),
        ],
      ),
      body: SafeArea(
        child: PopScope(
          canPop: (widget.contact != null || _recipient == null) &&
              _subjectController.text.isEmpty &&
              _messageController.text.isEmpty &&
              _attachments.isEmpty,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;

            await showDialog<void>(
              context: context,
              builder: (_) => QuitCreatingMessageDialog(accountId: widget.accountId),
            );
          },
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChooseContact(
                    accountId: widget.accountId,
                    contact: widget.contact ?? _recipient,
                    relationships: _relationships,
                    showRemoveContact: widget.contact == null,
                    selectContact: _updateChoosenContact,
                  ),
                  const Divider(height: 2),
                  TextField(
                    controller: _subjectController,
                    focusNode: _subjectFocusNode,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                      hintText: context.l10n.mailbox_subject,
                      hintStyle: _subjectFocusNode.hasFocus
                          ? Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary)
                          : Theme.of(context).textTheme.bodyLarge,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ).copyWith(contentPadding: const EdgeInsets.all(16)),
                  ),
                  const Divider(height: 2),
                  _SelectedAttachments(
                    attachments: _attachments,
                    onSelectedAttachmentsChanged: () => setState(() {}),
                    removeAttachment: (file) => setState(() => _attachments.remove(file)),
                    accountId: widget.accountId,
                  ),
                  const Divider(height: 2),
                  TextField(
                    controller: _messageController,
                    focusNode: _messageFocusNode,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration.collapsed(
                      hintText: context.l10n.mailbox_writeMessage,
                      hintStyle: _messageFocusNode.hasFocus
                          ? Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary)
                          : Theme.of(context).textTheme.bodyLarge,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ).copyWith(contentPadding: const EdgeInsets.all(16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get _canSendMail =>
      _recipient != null && (_subjectController.text.isNotEmpty || _messageController.text.isNotEmpty || _attachments.isNotEmpty);

  void _updateChoosenContact(IdentityDVO? contact) {
    if (mounted) {
      setState(() => _recipient = contact);
    }
  }

  Future<void> _loadContacts({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncEverything();

    final relationships = await getActiveContacts(session: session);

    if (mounted) setState(() => _relationships = relationships);
  }

  Future<void> _sendMessage() async {
    setState(() => _sendingMail = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    unawaited(showLoadingDialog(context, context.l10n.mailbox_sending));

    final messageResult = await session.transportServices.messages.sendMessage(
      recipients: [_recipient!.id],
      content: Mail(to: [_recipient!.id], subject: _subjectController.text, body: _messageController.text).toJson(),
      attachments: _attachments.map((file) => file.id).toList(),
    );

    if (messageResult.isSuccess && context.mounted) {
      context
        ..pop()
        ..pop();

      return;
    }

    if (mounted) context.pop();

    GetIt.I.get<Logger>().e('Sending message failed caused by: ${messageResult.error.message}');
    if (mounted) {
      setState(() => _sendingMail = false);

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
            content: Text(context.l10n.mailbox_error),
          );
        },
      );
    }
  }
}

class _SelectedAttachments extends StatelessWidget {
  final List<FileDVO> attachments;
  final VoidCallback onSelectedAttachmentsChanged;
  final void Function(FileDVO) removeAttachment;
  final String accountId;

  const _SelectedAttachments({
    required this.attachments,
    required this.onSelectedAttachmentsChanged,
    required this.removeAttachment,
    required this.accountId,
  });

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) {
      return Ink(
        child: InkWell(
          onTap: () => _updateAttachments(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(context.l10n.mailbox_attachments_button, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: AttachmentsList(
        attachments: attachments,
        accountId: accountId,
        removeFile: removeAttachment,
        trailing: IconButton(
          icon: const Icon(Icons.attach_file),
          onPressed: () => _updateAttachments(context),
        ),
      ),
    );
  }

  Future<void> _updateAttachments(BuildContext context) async {
    FocusScope.of(context).unfocus();

    await openFileChooser(
      context: context,
      accountId: accountId,
      selectedFiles: attachments,
      onSelectedAttachmentsChanged: onSelectedAttachmentsChanged,
      title: context.l10n.mailbox_selectAttachments_title,
      description: context.l10n.mailbox_selectAttachments_description,
    );
  }
}
