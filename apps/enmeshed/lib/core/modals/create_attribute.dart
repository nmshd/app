import 'dart:async';
import 'dart:math';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';
import 'package:value_renderer/value_renderer.dart';

import '../types/types.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

Future<void> showCreateAttributeModal({
  required BuildContext context,
  required String accountId,
  required void Function({required BuildContext context, required IdentityAttributeValue value})? onCreateAttributePressed,
  required VoidCallback? onAttributeCreated,
  String? initialValueType,
}) async {
  assert(
    (onCreateAttributePressed != null && onAttributeCreated == null) || (onCreateAttributePressed == null && onAttributeCreated != null),
    'Either onCreateAttributePressed or onAttributeCreated must be provided',
  );

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (builder) => _CreateAttributeContent(
      accountId: accountId,
      onCreateAttributePressed: onCreateAttributePressed,
      onAttributeCreated: onAttributeCreated,
      initialValueType: initialValueType,
    ),
  );
}

class _CreateAttributeContent extends StatefulWidget {
  final String accountId;
  final String? initialValueType;
  final VoidCallback? onAttributeCreated;
  final void Function({required BuildContext context, required IdentityAttributeValue value})? onCreateAttributePressed;

  const _CreateAttributeContent({
    required this.accountId,
    required this.initialValueType,
    required this.onAttributeCreated,
    required this.onCreateAttributePressed,
  });

  @override
  State<_CreateAttributeContent> createState() => __CreateAttributeContentState();
}

class __CreateAttributeContentState extends State<_CreateAttributeContent> {
  String? _valueType;

  late RenderHints _renderHints;
  late ValueHints _valueHints;
  late int _pageIndex;

  @override
  void initState() {
    super.initState();

    if (widget.initialValueType != null) _setValueTypeAndHints(widget.initialValueType!);

    _pageIndex = widget.initialValueType != null ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialValueType != null && _valueType == null) return const SizedBox.shrink();

    return AnimatedSwitcher(
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
      reverseDuration: _pageIndex == 0 ? Duration.zero : null,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: child is _SelectValueTypePage ? const Offset(-1, 0) : const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        );
      },
      child: _pageIndex == 0
          ? _SelectValueTypePage(accountId: widget.accountId, onValueTypeSelected: _onValueTypeSelected)
          : _CreateAttributePage(
              accountId: widget.accountId,
              initialValueType: widget.initialValueType,
              valueType: _valueType!,
              renderHints: _renderHints,
              valueHints: _valueHints,
              onBackPressed: () => setState(() => _pageIndex = 0),
              onAttributeCreated: widget.onAttributeCreated,
              onCreateAttributePressed: widget.onCreateAttributePressed,
            ),
    );
  }

  Future<void> _onValueTypeSelected(String valueType) async {
    await _setValueTypeAndHints(valueType);

    setState(() => _pageIndex = 1);
  }

  Future<void> _setValueTypeAndHints(String valueType) async {
    final hintsResult = await GetIt.I.get<EnmeshedRuntime>().getHints(valueType);

    if (hintsResult.isSuccess) {
      final hints = hintsResult.value;

      setState(() {
        _valueType = valueType;
        _renderHints = hints.renderHints;
        _valueHints = hints.valueHints;
      });

      return;
    }

    GetIt.I.get<Logger>().e('Getting attribute hints failed caused by: ${hintsResult.error}');

    if (mounted) {
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
            content: Text(context.l10n.errorDialog_description),
          );
        },
      );
    }
  }
}

class _SelectValueTypePage extends StatelessWidget {
  final String accountId;
  final void Function(String) onValueTypeSelected;

  const _SelectValueTypePage({required this.accountId, required this.onValueTypeSelected});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      child: Padding(
        padding: EdgeInsets.only(bottom: max(MediaQuery.viewInsetsOf(context).bottom, MediaQuery.viewPaddingOf(context).bottom)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetHeader(title: context.l10n.myData_createInformation, canClose: true),
            _EditableAttributes(accountId: accountId, goToNextPage: onValueTypeSelected),
          ],
        ),
      ),
    );
  }
}

class _CreateAttributePage extends StatefulWidget {
  final String accountId;
  final String? initialValueType;
  final String valueType;
  final RenderHints renderHints;
  final ValueHints valueHints;
  final VoidCallback onBackPressed;
  final VoidCallback? onAttributeCreated;
  final void Function({required BuildContext context, required IdentityAttributeValue value})? onCreateAttributePressed;

  const _CreateAttributePage({
    required this.accountId,
    required this.initialValueType,
    required this.valueType,
    required this.renderHints,
    required this.valueHints,
    required this.onBackPressed,
    required this.onAttributeCreated,
    required this.onCreateAttributePressed,
  });

  @override
  State<_CreateAttributePage> createState() => _CreateAttributePageState();
}

class _CreateAttributePageState extends State<_CreateAttributePage> {
  final _controller = ValueRendererController();
  final _scrollController = ScrollController();

  late IdentityAttributeValue? _identityAttribute;
  bool _confirmEnabled = false;
  String? _errorCode;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final value = _controller.value;

      if (value is ValueRendererValidationError) {
        setState(() => _confirmEnabled = false);
        return;
      }

      final canCreateAttribute = composeIdentityAttributeValue(
        isComplex: widget.renderHints.editType == RenderHintsEditType.Complex,
        currentAddress: '',
        valueType: widget.valueType,
        inputValue: value as ValueRendererInputValue,
      );

      if (canCreateAttribute != null) {
        _identityAttribute = canCreateAttribute.value;
        setState(() => _confirmEnabled = true);
      } else {
        setState(() => _confirmEnabled = false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translatedAttribute = FlutterI18n.translate(context, 'dvo.attribute.name.${widget.valueType}');

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      child: Padding(
        padding: EdgeInsets.only(bottom: max(MediaQuery.viewInsetsOf(context).bottom, MediaQuery.viewPaddingOf(context).bottom)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetHeader(
              onBackPressed: widget.initialValueType == null ? widget.onBackPressed : null,
              title: context.l10n.myData_createAttribute_title(translatedAttribute),
              canClose: true,
            ),
            Flexible(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (addressDataInitialAttributeTypes.contains(widget.valueType)) ...[
                        Text(context.l10n.mandatoryField, style: Theme.of(context).textTheme.bodyMedium),
                        Gaps.h24,
                      ],
                      ValueRenderer(
                        renderHints: widget.renderHints,
                        valueHints: widget.valueHints,
                        controller: _controller,
                        valueType: widget.valueType,
                        expandFileReference: (fileReference) => expandFileReference(accountId: widget.accountId, fileReference: fileReference),
                        chooseFile: () => openFileChooser(context: context, accountId: widget.accountId),
                        openFileDetails: (file) => context.push(
                          '/account/${widget.accountId}/my-data/files/${file.id}',
                          extra: createFileRecord(file: file),
                        ),
                      ),
                      if (_isDuplicateEntryError(_errorCode)) const _DuplicateEntryErrorContainer(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
                  FilledButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                    onPressed: !_confirmEnabled ? null : _onCreateAttributePressed,
                    child: Text(context.l10n.save),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onCreateAttributePressed() async {
    setState(() => _confirmEnabled = false);

    if (widget.onCreateAttributePressed != null) {
      widget.onCreateAttributePressed!(context: context, value: _identityAttribute!);

      return;
    }

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final createAttributeResult = await session.consumptionServices.attributes.createRepositoryAttribute(value: _identityAttribute!);

    if (createAttributeResult.isSuccess) {
      if (mounted) context.pop();

      widget.onAttributeCreated!();

      return;
    }

    GetIt.I.get<Logger>().e('Creating new attribute failed caused by: ${createAttributeResult.error}');

    final errorCode = createAttributeResult.error.code;
    if (_isDuplicateEntryError(errorCode)) {
      setState(() => _errorCode = errorCode);
      _scrollToBottom();

      return;
    }

    if (!mounted) return;

    context.pop();

    unawaited(
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(Icons.cancel, color: Theme.of(context).colorScheme.error),
          title: Text(context.l10n.personalData_details_errorTitleOnCreate, style: Theme.of(context).textTheme.headlineSmall),
          content: Text(context.l10n.personalData_details_errorContentOnCreate),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(context.l10n.back),
            ),
          ],
        ),
      ),
    );
  }

  bool _isDuplicateEntryError(String? errorCode) => errorCode != null && errorCode.contains('cannotCreateDuplicateRepositoryAttribute');

  void _scrollToBottom() {
    if (!_scrollController.hasClients || !_scrollController.position.hasViewportDimension) return;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class _EditableAttributes extends StatefulWidget {
  final void Function(String valueType) goToNextPage;
  final String accountId;

  const _EditableAttributes({required this.accountId, required this.goToNextPage});

  @override
  State<_EditableAttributes> createState() => _EditableAttributesState();
}

class _EditableAttributesState extends State<_EditableAttributes> {
  List<({String key, String translation})>? _editableAttributes;

  @override
  void initState() {
    super.initState();

    _loadEditableAttributes();
  }

  @override
  Widget build(BuildContext context) {
    if (_editableAttributes == null) {
      return Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewPaddingOf(context).bottom),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_editableAttributes!.isEmpty) {
      return EmptyListIndicator(icon: Icons.co_present_outlined, text: context.l10n.no_data_available, wrapInListView: true);
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(context.l10n.myData_chooseInformationType),
            ),
            Gaps.h16,
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _editableAttributes!.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_editableAttributes![index].translation),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => widget.goToNextPage(_editableAttributes![index].key),
              ),
              separatorBuilder: (context, index) => const Divider(height: 0, indent: 16),
            ),
            SizedBox(height: MediaQuery.viewPaddingOf(context).bottom),
          ],
        ),
      ),
    );
  }

  Future<void> _loadEditableAttributes({bool syncBefore = false}) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    if (syncBefore) await session.transportServices.account.syncDatawallet();

    final editableAttributes = await GetIt.I.get<EnmeshedRuntime>().getEditableAttributes();

    editableAttributes
      ..remove('SchematizedXML')
      ..remove('Affiliation');

    ({String key, String translation}) translate(String s) => (key: s, translation: context.i18nTranslate('i18n://dvo.attribute.name.$s'));

    final translated = editableAttributes.map(translate).toList()..sort((a, b) => a.translation.compareTo(b.translation));
    if (mounted) setState(() => _editableAttributes = translated);
  }
}

class _DuplicateEntryErrorContainer extends StatelessWidget {
  const _DuplicateEntryErrorContainer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
            Gaps.w4,
            Expanded(
              child: Text(
                context.l10n.createAttribute_error_duplicateValue,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onError),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
