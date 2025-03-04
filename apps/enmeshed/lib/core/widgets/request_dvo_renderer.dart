import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';

import '../modals/create_attribute.dart';
import '../types/types.dart';
import '../utils/utils.dart';
import 'contact_circle_avatar.dart';
import 'file_chooser.dart';

class RequestDVORenderer extends StatefulWidget {
  final String accountId;
  final String requestId;
  final bool isIncoming;
  final String acceptRequestText;
  final String validationErrorDescription;
  final VoidCallback onAfterAccept;
  final bool showHeader;
  final LocalRequestDVO? requestDVO;
  final String? description;
  final Future<bool> Function()? validateCreateRelationship;

  const RequestDVORenderer({
    required this.accountId,
    required this.requestId,
    required this.isIncoming,
    required this.acceptRequestText,
    required this.validationErrorDescription,
    required this.onAfterAccept,
    required this.validateCreateRelationship,
    this.showHeader = true,
    this.requestDVO,
    this.description,
    super.key,
  });

  @override
  State<RequestDVORenderer> createState() => _RequestDVORendererState();
}

class _RequestDVORendererState extends State<RequestDVORenderer> {
  final _formKey = GlobalKey<FormState>();

  final _scrollController = ScrollController();
  late RequestRendererController _controller;

  LocalRequestDVO? _request;
  RequestValidationResultDTO? _validationResult;
  GetIdentityInfoResponse? _identityInfo;

  bool _loading = false;

  @override
  void initState() {
    super.initState();

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    _request = widget.requestDVO;

    _updateIdentityInfo();

    if (_request == null) {
      _loadRequest(session);
    } else {
      _setController(session, _request!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RequestDVORenderer oldWidget) {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (oldWidget.requestDVO?.id != widget.requestDVO?.id && oldWidget.requestDVO?.status != widget.requestDVO?.status) {
      _request = widget.requestDVO;
      _controller.dispose();

      _updateIdentityInfo();

      if (_request == null) {
        _loadRequest(session);
      } else {
        _setController(session, _request!);
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_request == null || _identityInfo == null) {
      return const Center(child: SizedBox(height: 150, width: 159, child: CircularProgressIndicator(strokeWidth: 12)));
    }

    return Column(
      children: [
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.showHeader) ...[
                    if (widget.description != null) Padding(padding: const EdgeInsets.all(16), child: Text(widget.description!)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          ContactCircleAvatar(contact: _request!.peer, radius: 31),
                          Gaps.w16,
                          Expanded(
                            child: Text(
                              _request!.peer.isUnknown ? context.l10n.contacts_unknown : _request!.peer.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (_validationResult != null && !_validationResult!.isSuccess)
                    _RequestRenderErrorContainer(
                      errorCount: _validationResult!.countOfValidationErrors,
                      validationErrorDescription: widget.validationErrorDescription,
                    ),
                  if (_request!.isDecidable) Padding(padding: const EdgeInsets.all(16), child: Text(context.l10n.mandatoryField)),
                  RequestRenderer(
                    formKey: _formKey,
                    request: _request!,
                    controller: _controller,
                    currentAddress: _identityInfo!.address,
                    openAttributeSwitcher: _openAttributeSwitcher,
                    expandFileReference: (fileReference) => expandFileReference(accountId: widget.accountId, fileReference: fileReference),
                    chooseFile: () => openFileChooser(context: context, accountId: widget.accountId),
                    openFileDetails:
                        (file) => context.push('/account/${widget.accountId}/my-data/files/${file.id}', extra: createFileRecord(file: file)),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_request!.isDecidable)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: _loading && _request != null ? null : _rejectRequest, child: Text(context.l10n.reject)),
                Gaps.w8,
                FilledButton(onPressed: _onAcceptButtonPressed, child: Text(widget.acceptRequestText)),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _loadRequest(Session session) async {
    final requestDto =
        widget.isIncoming
            ? await session.consumptionServices.incomingRequests.getRequest(requestId: widget.requestId)
            : await session.consumptionServices.outgoingRequests.getRequest(requestId: widget.requestId);
    final request = await session.expander.expandLocalRequestDTO(requestDto.value);

    _setController(session, request);
    setState(() => _request = request);
  }

  Future<void> _updateIdentityInfo() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final identityInfo = await session.transportServices.account.getIdentityInfo();
    if (identityInfo.isError) return;

    setState(() => _identityInfo = identityInfo.value);
  }

  void _setController(Session session, LocalRequestDVO request) => _controller = RequestRendererController(request: request);

  Future<void> _onAcceptButtonPressed() async {
    final canCreateRelationship = await widget.validateCreateRelationship?.call();

    if (canCreateRelationship == false) return;

    await _acceptRequest();
  }

  Future<void> _acceptRequest() async {
    if (_loading) return;

    final params = _controller.value;
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final result = await session.consumptionServices.incomingRequests.canAccept(params: params);
    if (result.isError) return GetIt.I.get<Logger>().e(result.error);

    setState(() => _validationResult = result.value);

    if (!result.value.isSuccess) {
      _formKey.currentState?.validate();
      await _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      return;
    }

    if (!mounted) return;

    setState(() => _loading = true);

    unawaited(showLoadingDialog(context, context.l10n.request_accepting));

    final acceptResult = await session.consumptionServices.incomingRequests.accept(params: params);
    if (acceptResult.isError) {
      GetIt.I.get<Logger>().e('Can not accept request: ${result.error}');

      if (mounted) context.pop();
      // TODO(jkoenig134): show error to user.

      return;
    }

    if (mounted) context.pop();
    widget.onAfterAccept();
  }

  Future<void> _rejectRequest() async {
    setState(() => _loading = true);

    unawaited(showLoadingDialog(context, context.l10n.request_rejecting));

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final canReject = await session.consumptionServices.incomingRequests.canReject(params: _controller.rejectParams);
    if (canReject.isError) {
      setState(() => _loading = false);

      // TODO(jkoenig134): show error to user

      GetIt.I.get<Logger>().e('Can not reject request: ${canReject.error}');

      return;
    }

    final rejectResult = await session.consumptionServices.incomingRequests.reject(params: _controller.rejectParams);
    if (rejectResult.isError) {
      setState(() => _loading = false);
      // TODO(jkoenig134): show error to user

      GetIt.I.get<Logger>().e('Can not reject request: ${canReject.error}');

      return;
    }

    if (mounted) {
      context
        ..pop()
        ..pop();
    }
  }

  Future<AttributeSwitcherChoice?> _openAttributeSwitcher({
    required String? valueType,
    required List<AttributeSwitcherChoice> choices,
    required AttributeSwitcherChoice? currentChoice,
    ValueHints? valueHints,
  }) async {
    final choice = await Navigator.of(context).push<AttributeSwitcherChoice?>(
      MaterialPageRoute(
        builder:
            (ctx) => _AttributeSwitcher(
              choices: choices,
              currentChoice: currentChoice,
              valueHints: valueHints,
              valueType: valueType,
              accountId: widget.accountId,
              currentAddress: _identityInfo!.address,
            ),
      ),
    );

    return choice;
  }
}

class _AttributeSwitcher extends StatefulWidget {
  final List<AttributeSwitcherChoice> choices;
  final AttributeSwitcherChoice? currentChoice;
  final String? valueType;
  final String accountId;
  final String currentAddress;
  final ValueHints? valueHints;

  const _AttributeSwitcher({
    required this.choices,
    required this.currentChoice,
    required this.valueType,
    required this.accountId,
    required this.currentAddress,
    this.valueHints,
  });

  @override
  State<_AttributeSwitcher> createState() => _AttributeSwitcherState();
}

class _AttributeSwitcherState extends State<_AttributeSwitcher> {
  AttributeSwitcherChoice? selectedOption;

  @override
  void initState() {
    super.initState();

    selectedOption = widget.currentChoice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.valueType != null ? TranslatedText('i18n://dvo.attribute.name.${widget.valueType}') : Text(context.l10n.contactDetail_entry),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (widget.valueType != null)
                  Text(context.l10n.contactDetail_selectOrCreateEntryMessage)
                else
                  Text(context.l10n.contactDetail_selectEntryMessage),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.l10n.myEntries, style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (widget.valueType != null)
                      TextButton.icon(
                        icon: const Icon(Icons.add, size: 16),
                        label: Text(context.l10n.contactDetail_addEntry),
                        onPressed:
                            () => showCreateAttributeModal(
                              context: context,
                              accountId: widget.accountId,
                              onCreateAttributePressed:
                                  ({required BuildContext context, required IdentityAttributeValue value}) =>
                                      context
                                        ..pop()
                                        ..pop((id: null, attribute: IdentityAttribute(owner: widget.currentAddress, value: value))),
                              initialValueType: widget.valueType,
                              onAttributeCreated: null,
                            ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: widget.choices.length,
              separatorBuilder: (context, index) => Divider(height: 0, color: Theme.of(context).colorScheme.outline),
              itemBuilder: (context, index) {
                final item = widget.choices[index];

                return ColoredBox(
                  color: Theme.of(context).colorScheme.onPrimary,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.valueHints != null)
                          Expanded(
                            child: AttributeRenderer(
                              attribute: item.attribute,
                              valueHints: widget.valueHints!,
                              showTitle: false,
                              expandFileReference: (fileReference) => expandFileReference(accountId: widget.accountId, fileReference: fileReference),
                              openFileDetails:
                                  (file) =>
                                      context.push('/account/${widget.accountId}/my-data/files/${file.id}', extra: createFileRecord(file: file)),
                            ),
                          ),
                        Radio<AttributeSwitcherChoice>(
                          value: item,
                          groupValue: selectedOption,
                          onChanged: (AttributeSwitcherChoice? value) => setState(() => selectedOption = value),
                        ),
                      ],
                    ),
                    onTap: () => setState(() => selectedOption = item),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 16, bottom: MediaQuery.viewPaddingOf(context).bottom, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
                  FilledButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                    onPressed: () => context.pop(selectedOption),
                    child: Text(context.l10n.save),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestRenderErrorContainer extends StatelessWidget {
  final int errorCount;
  final String validationErrorDescription;

  const _RequestRenderErrorContainer({required this.errorCount, required this.validationErrorDescription});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.errorContainer, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.error, color: Theme.of(context).colorScheme.error),
              Gaps.w8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.contact_request_validationError(errorCount),
                      style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
                    ),
                    Gaps.h8,
                    Text(
                      validationErrorDescription,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onErrorContainer),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on RequestValidationResultDTO {
  int get countOfValidationErrors {
    if (items.isEmpty) return isSuccess ? 0 : 1;

    return items.map((item) => item.countOfValidationErrors).reduce((a, b) => a + b);
  }
}
