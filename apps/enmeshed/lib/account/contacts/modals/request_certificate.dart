import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/core/core.dart';

Future<void> showRequestCertificateModal({required BuildContext context, required Session session, required String peer}) async {
  final pageIndexNotifier = ValueNotifier<int>(0);

  final title = Padding(
    padding: const EdgeInsets.only(left: 24, top: 20),
    child: Text(context.l10n.contactDetail_requestCertificate, style: Theme.of(context).textTheme.titleLarge),
  );

  final closeButton = Padding(
    padding: const EdgeInsets.only(right: 8),
    child: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
  );

  await WoltModalSheet.show<void>(
    useSafeArea: false,
    context: context,
    pageIndexNotifier: pageIndexNotifier,
    onModalDismissedWithBarrierTap: () => pageIndexNotifier.value != 1 ? context.pop() : null,
    showDragHandle: false,
    pageListBuilder: (context) => [
      WoltModalSheetPage(
        leadingNavBarWidget: title,
        trailingNavBarWidget: closeButton,
        child: _RequestCertificate(
          send: ({required String title, required String freeText}) => _requestCertificate(
            session: session,
            title: title,
            freeText: freeText,
            peer: peer,
            onLoad: () => pageIndexNotifier.value = 1,
            onDone: () => pageIndexNotifier.value = 2,
            onError: () {
              pageIndexNotifier.value = 0;
              showErrorSnackbar(context: context, text: context.l10n.contactDetail_requestCertificate_error);
            },
          ),
        ),
      ),
      WoltModalSheetPage(enableDrag: false, child: const _SendCertificateLoading()),
      WoltModalSheetPage(trailingNavBarWidget: closeButton, child: const _SendCertificateSuccess()),
    ],
  );
}

Future<void> _requestCertificate({
  required Session session,
  required String title,
  required String freeText,
  required String peer,
  required VoidCallback onLoad,
  required VoidCallback onDone,
  required VoidCallback onError,
}) async {
  onLoad();

  final content = Request(items: [FreeTextRequestItem(mustBeAccepted: true, freeText: freeText, title: title)]);

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
    content: createRequestResult.value.content.toJson(),
    recipients: [peer],
  );
  if (sendMessageResult.isError) {
    onError();
    return;
  }

  onDone();
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
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
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
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: _confirmEnabled ? _send : null,
              style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
              child: Text(context.l10n.contactDetail_requestCertificate_send),
            ),
          ),
        ],
      ),
    );
  }

  void _send() {
    widget.send(title: _titleController.text, freeText: _freeTextController.text);
  }
}

class _SendCertificateLoading extends StatelessWidget {
  const _SendCertificateLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 60, width: 60, child: CircularProgressIndicator(strokeWidth: 12)),
          const SizedBox(height: 38),
          Text(
            context.l10n.contactDetail_requestCertificate_inProgress,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SendCertificateSuccess extends StatelessWidget {
  const _SendCertificateSuccess();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded, size: 160, color: context.customColors.successIcon),
          Gaps.h24,
          Text(
            context.l10n.contactDetail_requestCertificate_success,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Gaps.h40,
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: () => context.pop(),
              style: OutlinedButton.styleFrom(minimumSize: const Size(80, 36)),
              child: Text(context.l10n.contactDetail_requestCertificate_successOk),
            ),
          ),
        ],
      ),
    );
  }
}
