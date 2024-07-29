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
  List<FileDVO> _attachments = [];
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
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
          title: Text(context.l10n.mailbox_new_message),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        title: Text(context.l10n.mailbox_new_message),
        actions: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              final selectedAttachments = await context.push('/account/${widget.accountId}/mailbox/send/select-attachments', extra: _attachments);
              _attachments = selectedAttachments != null ? selectedAttachments as List<FileDVO> : [];
            },
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: _canSendMail && !_sendingMail ? _sendMessage : null),
        ],
      ),
      body: SafeArea(
        child: PopScope(
          canPop: (widget.contact != null || _recipient == null) &&
              _subjectController.text.isEmpty &&
              _messageController.text.isEmpty &&
              _attachments.isEmpty,
          onPopInvoked: (didPop) async {
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
                    removeContact: widget.contact == null ? _updateChoosenContact : null,
                    selectContact: _updateChoosenContact,
                  ),
                  const Divider(height: 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: _subjectController,
                      focusNode: _subjectFocusNode,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: null,
                      decoration: InputDecoration.collapsed(
                        hintText: context.l10n.mailbox_subject,
                        hintStyle: _subjectFocusNode.hasFocus
                            ? Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary)
                            : Theme.of(context).textTheme.bodyLarge,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                  const Divider(height: 0),
                  if (_attachments.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: AttachmentsList(
                        attachments: _attachments,
                        accountId: widget.accountId,
                        removeFile: (index) => setState(() => _attachments.removeAt(index)),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _messageController,
                      focusNode: _messageFocusNode,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration.collapsed(
                        hintText: context.l10n.mailbox_writeMessage,
                        hintStyle: _messageFocusNode.hasFocus
                            ? Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary)
                            : Theme.of(context).textTheme.bodyLarge,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
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
      content: Mail(to: [_recipient!.id], subject: _subjectController.text, body: _messageController.text),
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
