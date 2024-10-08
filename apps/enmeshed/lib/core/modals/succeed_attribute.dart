import 'dart:async';
import 'dart:math';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';
import 'package:value_renderer/value_renderer.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../constants.dart';
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

  IdentityAttributeValue? attributeValue;

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
              onPressed: () => context
                ..pop()
                ..pop(),
              child: Text(context.l10n.back),
            ),
          ],
        );
      },
    );
  }

  final renderHints = attribute.renderHints;
  final valueHints = attribute.valueHints;

  bool hasDataChanged(LocalAttributeDVO attributeToCheck) {
    final attributeData = attributeToCheck.value.toJson()..removeWhere((key, value) => key == '@type');
    final controllerData = (controller.value as ValueRendererInputValue).getValue();

    return !mapEquals(attributeData, controllerData);
  }

  bool isAnyOtherVersionSameAsCurrent() {
    final attributesWithoutCurrentAttribute = sameTypeAttributes.where((element) => element.id != attribute.id).toList();
    return attributesWithoutCurrentAttribute.any((element) => !hasDataChanged(element));
  }

  void handleControllerChange() {
    final value = controller.value;

    if (value is ValueRendererValidationError) {
      succeedEnabledNotifier.value = false;
      return;
    }

    final canSucceedAttribute = composeIdentityAttributeValue(
      isComplex: renderHints.editType == RenderHintsEditType.Complex,
      currentAddress: attribute.owner,
      valueType: attribute.valueType,
      inputValue: value as ValueRendererInputValue,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (succeedEnabledNotifier.value == false && !hasDataChanged(attribute)) {
        errorTextNotifier.value = context.l10n.personalData_details_errorOnSuccession;
      } else if (isAnyOtherVersionSameAsCurrent()) {
        errorTextNotifier.value = context.l10n.personalData_details_warningOnSuccession;
      } else {
        errorTextNotifier.value = null;
      }
    });

    if (canSucceedAttribute != null) {
      attributeValue = canSucceedAttribute.value;
      succeedEnabledNotifier.value = true;
    } else {
      succeedEnabledNotifier.value = false;
    }
  }

  controller.addListener(handleControllerChange);

  Future<void> succeedAttributeAndNotifyPeers() async {
    if (!hasDataChanged(attribute)) {
      succeedEnabledNotifier.value = false;
      errorTextNotifier.value = context.l10n.personalData_details_errorOnSuccession;
      return;
    }

    succeedEnabledNotifier.value = false;

    String? successorId;

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

    final succeedAttributeResult =
        await session.consumptionServices.attributes.succeedRepositoryAttribute(predecessorId: attribute.id, value: attributeValue!);

    if (succeedAttributeResult.isSuccess) {
      successorId = succeedAttributeResult.value.successor.id;
    } else {
      if (context.mounted) {
        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
              content: Text(context.l10n.error_succeedAttribute),
            );
          },
        );

        succeedEnabledNotifier.value = true;
      }

      return;
    }

    for (final sharedToPeerAttribute in attribute.sharedWith) {
      final notificationResult = await session.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(
        attributeId: successorId,
        peer: sharedToPeerAttribute.peer,
      );

      if (notificationResult.isError) {
        GetIt.I.get<Logger>().e('Notify peer about repository attribute succession failed caused by: ${notificationResult.error}');
      }
    }

    if (context.mounted) context.pop();
    onAttributeSucceeded();

    controller.removeListener(handleControllerChange);
  }

  final closeButton = Padding(
    padding: const EdgeInsets.only(right: 8),
    child: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
  );

  if (!context.mounted) return;
  await WoltModalSheet.show<void>(
    useSafeArea: false,
    context: context,
    onModalDismissedWithDrag: () => context.pop(),
    onModalDismissedWithBarrierTap: () => context.pop(),
    showDragHandle: false,
    pageListBuilder: (context) => [
      WoltModalSheetPage(
        trailingNavBarWidget: closeButton,
        stickyActionBar: ValueListenableBuilder<bool>(
          valueListenable: succeedEnabledNotifier,
          builder: (context, enabled, child) {
            return Padding(
              padding: EdgeInsets.only(right: 24, bottom: max(MediaQuery.paddingOf(context).bottom, 24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => context.pop(),
                    child: Text(context.l10n.cancel),
                  ),
                  Gaps.w8,
                  FilledButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                    onPressed: !enabled ? null : succeedAttributeAndNotifyPeers,
                    child: Text(context.l10n.save),
                  ),
                ],
              ),
            );
          },
        ),
        leadingNavBarWidget: Padding(
          padding: const EdgeInsets.only(left: 24, top: 20, bottom: 24),
          child: Text(context.l10n.personalData_details_editEntry, style: Theme.of(context).textTheme.titleLarge),
        ),
        child: ValueListenableBuilder<String?>(
          valueListenable: errorTextNotifier,
          builder: (context, errorText, child) {
            return Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: max(MediaQuery.paddingOf(context).bottom, 16) + 72),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (addressDataInitialAttributeTypes.contains(attribute.valueType)) ...[
                    Text(context.l10n.mandatoryField, style: const TextStyle(fontSize: 14)),
                    Gaps.h24,
                  ],
                  ValueRenderer(
                    renderHints: renderHints,
                    valueHints: valueHints,
                    controller: controller,
                    initialValue: attribute.value,
                    valueType: attribute.valueType,
                    expandFileReference: (fileReference) => expandFileReference(accountId: accountId, fileReference: fileReference),
                    chooseFile: () => openFileChooser(context: context, accountId: accountId),
                    openFileDetails: (file) => context.push('/account/$accountId/my-data/files/${file.id}', extra: file),
                  ),
                  if (errorText != null) ...[
                    if (renderHints.editType != RenderHintsEditType.InputLike) Gaps.h16 else Gaps.h8,
                    Text(
                      errorText,
                      style: TextStyle(
                        color: errorText == context.l10n.personalData_details_errorOnSuccession ? Theme.of(context).colorScheme.error : null,
                      ),
                    ),
                  ],
                  if (attribute.sharedWith.isNotEmpty) ...[
                    Gaps.h16,
                    Text(context.l10n.personalData_details_notifyContacts(attribute.sharedWith.length)),
                    Gaps.h16,
                  ],
                ],
              ),
            );
          },
        ),
      ),
    ],
  );

  controller.dispose();
  succeedEnabledNotifier.dispose();
  errorTextNotifier.dispose();
}

extension on ValueRendererInputValue {
  Map<String, dynamic> getValue() {
    if (this is ValueRendererInputValueString) return {'value': (this as ValueRendererInputValueString).value};
    if (this is ValueRendererInputValueNum) return {'value': (this as ValueRendererInputValueNum).value};
    if (this is ValueRendererInputValueBool) return {'value': (this as ValueRendererInputValueBool).value};
    if (this is ValueRendererInputValueMap) {
      return Map<String, dynamic>.fromEntries(
        (toJson() as Map<String, dynamic>).entries.map(
              (e) => MapEntry(
                e.key,
                switch (e.value as ValueRendererInputValue) {
                  final ValueRendererInputValueString value => value,
                  final ValueRendererInputValueNum value => value,
                  final ValueRendererInputValueBool value => value,
                  final ValueRendererInputValueMap value => value,
                  final ValueRendererInputValueDateTime value => value,
                },
              ),
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
