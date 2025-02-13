import 'dart:async';

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
  final controller = ValueRendererController()..value = attribute.value;
  final succeedEnabledNotifier = ValueNotifier<bool>(true);
  final errorTextNotifier = ValueNotifier<String?>(null);

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
    builder:
        (context) => ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 600),
          child: _SucceedAttributeModal(
            accountId: accountId,
            attribute: attribute,
            onAttributeSucceeded: onAttributeSucceeded,
            sameTypeAttributes: sameTypeAttributes,
          ),
        ),
  );

  controller.dispose();
  succeedEnabledNotifier.dispose();
  errorTextNotifier.dispose();
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
  final controller = ValueRendererController();
  bool enabled = false;
  String? errorText;
  IdentityAttributeValue? attributeValue;

  @override
  void initState() {
    super.initState();

    controller
      ..value = widget.attribute
      ..addListener(handleControllerChange);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetHeader(title: context.l10n.personalData_details_editEntry),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewPaddingOf(context).bottom + 72),
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
                controller: controller,
                initialValue: widget.attribute.value,
                valueType: widget.attribute.valueType,
                expandFileReference: (fileReference) => expandFileReference(accountId: widget.accountId, fileReference: fileReference),
                chooseFile: () => openFileChooser(context: context, accountId: widget.accountId),
                openFileDetails: (file) => context.push('/account/${widget.accountId}/my-data/files/${file.id}', extra: createFileRecord(file: file)),
              ),
              if (errorText != null) ...[
                if (widget.attribute.renderHints.editType != RenderHintsEditType.InputLike) Gaps.h16 else Gaps.h8,
                Text(
                  errorText!,
                  style: TextStyle(
                    color: errorText == context.l10n.personalData_details_errorOnSuccession ? Theme.of(context).colorScheme.error : null,
                  ),
                ),
              ],
              if (widget.attribute.sharedWith.isNotEmpty) ...[
                Gaps.h16,
                Text(context.l10n.personalData_details_notifyContacts(widget.attribute.sharedWith.length)),
                Gaps.h16,
              ],
              Padding(
                padding: EdgeInsets.only(right: 24, bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
                    Gaps.w8,
                    FilledButton(
                      style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                      onPressed: !enabled ? null : succeedAttributeAndNotifyPeers,
                      child: Text(context.l10n.save),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> succeedAttributeAndNotifyPeers() async {
    if (!hasDataChanged(widget.attribute)) {
      setState(() {
        enabled = false;
        errorText = context.l10n.personalData_details_errorOnSuccession;
      });

      return;
    }

    setState(() => enabled = false);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    final succeedAttributeResult = await session.consumptionServices.attributes.succeedRepositoryAttribute(
      predecessorId: widget.attribute.id,
      value: attributeValue!,
    );

    if (succeedAttributeResult.isError) {
      if (mounted) {
        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
              content: Text(context.l10n.error_succeedAttribute),
            );
          },
        );

        setState(() => enabled = true);
      }

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

    controller.removeListener(handleControllerChange);
  }

  void handleControllerChange() {
    final value = controller.value;

    if (value is ValueRendererValidationError) {
      setState(() => enabled = false);
      return;
    }

    final canSucceedAttribute = composeIdentityAttributeValue(
      isComplex: widget.attribute.renderHints.editType == RenderHintsEditType.Complex,
      currentAddress: widget.attribute.owner,
      valueType: widget.attribute.valueType,
      inputValue: value as ValueRendererInputValue,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (enabled == false && !hasDataChanged(widget.attribute)) {
        errorText = context.l10n.personalData_details_errorOnSuccession;
      } else if (isAnyOtherVersionSameAsCurrent()) {
        errorText = context.l10n.personalData_details_warningOnSuccession;
      } else {
        errorText = null;
      }
    });

    if (canSucceedAttribute != null) {
      attributeValue = canSucceedAttribute.value;
      setState(() => enabled = true);
    } else {
      setState(() => enabled = false);
    }
  }

  bool hasDataChanged(LocalAttributeDVO x) {
    final attributeData = x.value.toJson()..removeWhere((key, value) => key == '@type');
    final controllerData = (controller.value as ValueRendererInputValue).getValue();

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
