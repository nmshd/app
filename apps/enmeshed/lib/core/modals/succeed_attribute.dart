import 'dart:async';
import 'dart:math' show max;

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';
import 'package:value_renderer/value_renderer.dart';

import '../types/types.dart';
import '../utils/utils.dart';
import '../widgets/file_chooser.dart';

Future<void> showSucceedAttributeModal({
  required BuildContext context,
  required String accountId,
  required LocalAttributeDVO attribute,
  required List<LocalAttributeDVO> sameTypeAttributes,
  required VoidCallback onAttributeSucceeded,
}) async {
  if (attribute is! RepositoryAttributeDVO) {
    if (!context.mounted) return;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
          content: Text(context.l10n.errorDialog_description, textAlign: TextAlign.center),
          actions: [
            FilledButton(
              onPressed:
                  () =>
                      context
                        ..pop()
                        ..pop(),
              child: Text(context.l10n.back),
            ),
          ],
        );
      },
    );
  }

  if (!context.mounted) return;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder:
        (context) => ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
          child: _SucceedAttributeModal(
            accountId: accountId,
            attribute: attribute,
            onAttributeSucceeded: onAttributeSucceeded,
            sameTypeAttributes: sameTypeAttributes,
          ),
        ),
  );
}

class _SucceedAttributeModal extends StatefulWidget {
  final String accountId;
  final RepositoryAttributeDVO attribute;
  final VoidCallback onAttributeSucceeded;
  final List<LocalAttributeDVO> sameTypeAttributes;

  const _SucceedAttributeModal({
    required this.accountId,
    required this.attribute,
    required this.onAttributeSucceeded,
    required this.sameTypeAttributes,
  });

  @override
  State<_SucceedAttributeModal> createState() => _SucceedAttributeModalState();
}

class _SucceedAttributeModalState extends State<_SucceedAttributeModal> {
  final _scrollController = ScrollController();
  final _controller = ValueRendererController();
  bool _enabled = false;
  bool _saving = false;
  String? _errorText;
  late IdentityAttributeValue _attributeValue;

  @override
  void initState() {
    super.initState();

    _controller
      ..value = widget.attribute
      ..addListener(() => WidgetsBinding.instance.addPostFrameCallback((_) => _handleControllerChange()));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomSheetHeader(title: context.l10n.personalData_details_editEntry, canClose: !_saving),
        Flexible(
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (addressDataInitialAttributeTypes.contains(widget.attribute.valueType)) ...[
                        Text(context.l10n.mandatoryField, style: const TextStyle(fontSize: 14)),
                        Gaps.h24,
                      ],
                      ValueRenderer(
                        renderHints: widget.attribute.renderHints,
                        valueHints: widget.attribute.valueHints,
                        controller: _controller,
                        initialValue: widget.attribute.value,
                        valueType: widget.attribute.valueType,
                        expandFileReference: (fileReference) => expandFileReference(accountId: widget.accountId, fileReference: fileReference),
                        chooseFile: () => openFileChooser(context: context, accountId: widget.accountId),
                        openFileDetails:
                            (file) => context.push('/account/${widget.accountId}/my-data/files/${file.id}', extra: createFileRecord(file: file)),
                      ),
                      if (_errorText != null) ...[
                        if (widget.attribute.renderHints.editType != RenderHintsEditType.InputLike) Gaps.h16 else Gaps.h8,
                        Text(_errorText!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                      ],
                      if (widget.attribute.sharedWith.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(context.l10n.personalData_details_notifyContacts(widget.attribute.sharedWith.length)),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 8,
            bottom: max(MediaQuery.viewPaddingOf(context).bottom, MediaQuery.viewInsetsOf(context).bottom) + 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: _saving ? null : () => context.pop(), child: Text(context.l10n.cancel)),
              Gaps.w8,
              FilledButton(onPressed: _saving || !_enabled ? null : _onSavePressed, child: Text(context.l10n.save)),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onSavePressed() async {
    if (!hasDataChanged(widget.attribute)) {
      await _setError(context.l10n.personalData_details_errorOnSuccession);
      return;
    }

    if (isAnyOtherVersionSameAsCurrent()) {
      await _setError(context.l10n.personalData_details_warningOnSuccession);
      return;
    }

    setState(() => _saving = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final succeedAttributeResult = await session.consumptionServices.attributes.succeedRepositoryAttribute(
      predecessorId: widget.attribute.id,
      value: _attributeValue,
    );

    if (succeedAttributeResult.isError) {
      if (!mounted) return;

      if (succeedAttributeResult.error.code == 'error.consumption.attributes.successionMustChangeContent') {
        await _setError(context.l10n.personalData_details_warningOnSuccession);
      } else {
        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
              content: Text(context.l10n.error_succeedAttribute),
            );
          },
        );
      }

      setState(() => _saving = false);

      return;
    }

    final successorId = succeedAttributeResult.value.successor.id;

    for (final sharedToPeerAttribute in widget.attribute.sharedWith) {
      final notificationResult = await session.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: successorId,
        peer: sharedToPeerAttribute.peer,
      );

      if (notificationResult.isError) {
        GetIt.I.get<Logger>().e('Notify peer about repository attribute succession failed caused by: ${notificationResult.error}');
      }
    }

    if (mounted) context.pop();
    widget.onAttributeSucceeded();
  }

  void _handleControllerChange() {
    final value = _controller.value;

    if (value is ValueRendererValidationError) {
      setState(() => _enabled = false);
      return;
    }

    setState(() {
      _enabled = true;
    });

    final attributeValue = composeIdentityAttributeValue(
      isComplex: widget.attribute.renderHints.editType == RenderHintsEditType.Complex,
      currentAddress: widget.attribute.owner,
      valueType: widget.attribute.valueType,
      inputValue: value as ValueRendererInputValue,
    );

    if (attributeValue == null) return;

    setState(() => _attributeValue = attributeValue.value);
  }

  Future<void> _setError(String error) async {
    setState(() => _errorText = error);

    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }

  bool hasDataChanged(LocalAttributeDVO x) {
    final attributeData = x.value.toJson()..removeWhere((key, value) => key == '@type');
    final controllerData = (_controller.value as ValueRendererInputValue).getValue();

    return !mapEquals(attributeData, controllerData);
  }

  bool isAnyOtherVersionSameAsCurrent() {
    final attributesWithoutCurrentAttribute = widget.sameTypeAttributes.where((element) => element.id != widget.attribute.id).toList();
    return attributesWithoutCurrentAttribute.any((element) => !hasDataChanged(element));
  }
}

extension on ValueRendererInputValue {
  Map<String, dynamic> getValue() {
    if (this is ValueRendererInputValueString) return {'value': (this as ValueRendererInputValueString).value};
    if (this is ValueRendererInputValueNum) return {'value': (this as ValueRendererInputValueNum).value};
    if (this is ValueRendererInputValueBool) return {'value': (this as ValueRendererInputValueBool).value};
    if (this is ValueRendererInputValueMap) {
      return Map<String, dynamic>.fromEntries(
        (toJson() as Map<String, dynamic>).entries.map(
          (e) => MapEntry(e.key, switch (e.value as ValueRendererInputValue) {
            final ValueRendererInputValueString value => value,
            final ValueRendererInputValueNum value => value,
            final ValueRendererInputValueBool value => value,
            final ValueRendererInputValueMap value => value,
            final ValueRendererInputValueDateTime value => value,
          }),
        ),
      );
    }
    if (this is ValueRendererInputValueDateTime) {
      return {
        'year': (this as ValueRendererInputValueDateTime).value.year,
        'month': (this as ValueRendererInputValueDateTime).value.month,
        'day': (this as ValueRendererInputValueDateTime).value.day,
      };
    }

    return {};
  }
}
