import 'dart:math' show max;

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

Future<void> showRequestCertificateModal({required BuildContext context, required Session session, required String peer}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder:
        (context) => ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
          child: _ModalSheet(session: session, peer: peer),
        ),
  );
}

class _ModalSheet extends StatefulWidget {
  final Session session;
  final String peer;

  const _ModalSheet({required this.session, required this.peer});

  @override
  State<_ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<_ModalSheet> {
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return ConditionalCloseable(
      canClose: !_sending,
      child: Stack(
        children: [
          _RequestCertificate(
            send:
                ({required String title, required String freeText}) =>
                    _requestCertificate(session: widget.session, title: title, freeText: freeText, peer: widget.peer),
          ),
          if (_sending) ModalLoadingOverlay(text: context.l10n.contactDetail_requestCertificate_inProgress, isDialog: false),
        ],
      ),
    );
  }

  Future<void> _requestCertificate({required Session session, required String title, required String freeText, required String peer}) async {
    setState(() => _sending = true);

    final content = Request(items: [FreeTextRequestItem(mustBeAccepted: true, freeText: freeText, title: title)]);

    void onError() {
      setState(() => _sending = false);
      showErrorSnackbar(context: context, text: context.l10n.contactDetail_requestCertificate_error);
    }

    final canCreateRequestResult = await session.consumptionServices.outgoingRequests.canCreate(content: content, peer: peer);
    if (canCreateRequestResult.isError) {
      onError();
      return;
    }

    final createRequestResult = await session.consumptionServices.outgoingRequests.create(content: content, peer: peer);
    if (createRequestResult.isError) {
      onError();
      return;
    }

    final sendMessageResult = await session.transportServices.messages.sendMessage(
      content: MessageContentRequest(request: createRequestResult.value.content),
      recipients: [peer],
    );
    if (sendMessageResult.isError) {
      onError();
      return;
    }

    if (!mounted) return;

    context.pop();
    showSuccessSnackbar(context: context, text: context.l10n.contactDetail_requestCertificate_success);
  }
}

class _RequestCertificate extends StatefulWidget {
  final void Function({required String title, required String freeText}) send;

  const _RequestCertificate({required this.send});

  @override
  State<_RequestCertificate> createState() => _RequestCertificateState();
}

class _RequestCertificateState extends State<_RequestCertificate> {
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();

  final TextEditingController _freeTextController = TextEditingController();
  final FocusNode _freeTextFocusNode = FocusNode();

  bool get _confirmEnabled => _titleController.text.isNotEmpty && _freeTextController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _titleFocusNode.requestFocus();

    _titleController.addListener(() => setState(() {}));
    _freeTextController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocusNode.dispose();

    _freeTextController.dispose();
    _freeTextFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomSheetHeader(title: context.l10n.contactDetail_requestCertificate),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 16,
              bottom: max(MediaQuery.viewPaddingOf(context).bottom, MediaQuery.viewInsetsOf(context).bottom),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    focusNode: _titleFocusNode,
                    controller: _titleController,
                    maxLength: 200,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: context.l10n.contactDetail_requestCertificate_subject,
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    onSubmitted: (value) => value.isEmpty ? _titleFocusNode.requestFocus() : _freeTextFocusNode.requestFocus(),
                  ),
                  Gaps.h8,
                  TextField(
                    focusNode: _freeTextFocusNode,
                    controller: _freeTextController,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: context.l10n.contactDetail_requestCertificate_text,
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                      ),
                    ),
                    onSubmitted: (value) => _confirmEnabled ? null : _titleFocusNode.requestFocus(),
                  ),
                  Gaps.h8,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton(
                        onPressed: _confirmEnabled ? _send : null,
                        style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                        child: Text(context.l10n.contactDetail_requestCertificate_send),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _send() {
    widget.send(title: _titleController.text, freeText: _freeTextController.text);
  }
}
