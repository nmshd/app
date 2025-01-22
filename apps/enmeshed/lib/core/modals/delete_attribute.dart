import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../utils/extensions.dart';

Future<void> showDeleteAttributeModal({
  required BuildContext context,
  required String accountId,
  required LocalAttributeDVO attribute,
  required VoidCallback onAttributeDeleted,
}) async {
  final deleteEnabledNotifier = ValueNotifier<bool>(true);

  final closeButton = Padding(
    padding: const EdgeInsets.only(right: 8),
    child: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
  );

  Future<void> deleteAttributeAndNotifyPeers() async {
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

    deleteEnabledNotifier.value = false;

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

    final deleteAttributeResult = await session.consumptionServices.attributes.deleteRepositoryAttribute(attributeId: attribute.id);

    if (deleteAttributeResult.isError) {
      GetIt.I.get<Logger>().e('Deleting attribute failed caused by: ${deleteAttributeResult.error}');

      if (context.mounted) {
        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(context.l10n.error, style: Theme.of(context).textTheme.titleLarge),
              content: Text(context.l10n.error_deleteAttribute),
            );
          },
        );
      }

      deleteEnabledNotifier.value = true;

      return;
    }

    for (final sharedToPeerAttribute in attribute.sharedWith) {
      final content = Request(items: [DeleteAttributeRequestItem(mustBeAccepted: true, attributeId: sharedToPeerAttribute.id)]);

      final canCreateRequestResult = await session.consumptionServices.outgoingRequests.canCreate(content: content, peer: sharedToPeerAttribute.peer);
      if (canCreateRequestResult.isError) {
        // TODO(scoen): error handling
        return;
      }

      final createRequestResult = await session.consumptionServices.outgoingRequests.create(content: content, peer: sharedToPeerAttribute.peer);
      if (createRequestResult.isError) {
        // TODO(scoen): error handling
        return;
      }

      final sendMessageResult = await session.transportServices.messages.sendMessage(
        content: MessageContentRequest(request: createRequestResult.value.content),
        recipients: [sharedToPeerAttribute.peer],
      );

      if (sendMessageResult.isError) {
        GetIt.I.get<Logger>().e('The request to the peer to delete the attribute has failed caused by: ${sendMessageResult.error}');
      }
    }

    onAttributeDeleted();

    if (context.mounted) context.pop();
  }

  await WoltModalSheet.show<void>(
    useSafeArea: false,
    context: context,
    onModalDismissedWithDrag: () => context.pop(),
    onModalDismissedWithBarrierTap: () => context.pop(),
    showDragHandle: false,
    pageListBuilder: (context) => [
      WoltModalSheetPage(
        trailingNavBarWidget: closeButton,
        topBarTitle: Text(context.l10n.personalData_details_deleteEntry, style: Theme.of(context).textTheme.titleMedium),
        isTopBarLayerAlwaysVisible: true,
        stickyActionBar: ValueListenableBuilder<bool>(
          valueListenable: deleteEnabledNotifier,
          builder: (context, enabled, child) {
            return Padding(
              padding: EdgeInsets.only(right: 24, bottom: MediaQuery.viewPaddingOf(context).bottom),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => context.pop(),
                    child: Text(context.l10n.personalData_details_cancelDeletion),
                  ),
                  Gaps.w8,
                  FilledButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                    onPressed: !enabled ? null : deleteAttributeAndNotifyPeers,
                    child: Text(context.l10n.personalData_details_confirmAttributeDeletion),
                  ),
                ],
              ),
            );
          },
        ),
        child: _DeleteConfirmation(attribute: attribute as RepositoryAttributeDVO),
      ),
    ],
  );

  deleteEnabledNotifier.dispose();
}

class _DeleteConfirmation extends StatelessWidget {
  final RepositoryAttributeDVO attribute;

  const _DeleteConfirmation({required this.attribute});

  @override
  Widget build(BuildContext context) {
    final isShared = attribute.sharedWith.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewPaddingOf(context).bottom + 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isShared)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(4)),
              child: Text(_getDisplayValue(context, attribute.value), style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
            ),
          Gaps.h16,
          const Align(
            alignment: Alignment.topCenter,
            child: VectorGraphic(loader: AssetBytesLoader('assets/svg/attribute_deletion.svg'), height: 136),
          ),
          Gaps.h16,
          if (isShared)
            Text(context.l10n.personalData_details_deleteDescriptionShared(attribute.sharedWith.length))
          else
            Text(context.l10n.personalData_details_deleteDescription('"${_getDisplayValue(context, attribute.value)}"')),
        ],
      ),
    );
  }

  String _getDisplayValue(BuildContext context, AttributeValue value) {
    return switch (value) {
      final AffiliationAttributeValue affiliation => affiliation.role,
      final BirthDateAttributeValue birthDate => _getBirtDateValue(context, birthDate),
      final BirthPlaceAttributeValue birthPlace => birthPlace.city,
      final DeliveryBoxAddressAttributeValue deliveryBoxAddress => deliveryBoxAddress.recipient,
      final PostOfficeBoxAddressAttributeValue postOfficeBoxAddress => postOfficeBoxAddress.recipient,
      final StreetAddressAttributeValue streetAddress => streetAddress.recipient,
      final PersonNameAttributeValue personName => '${personName.givenName} ${personName.surname}',
      _ => _getTranslatedEntry(context),
    };
  }

  String _getBirtDateValue(BuildContext context, BirthDateAttributeValue value) {
    final date = DateTime(value.year, value.month, value.day);

    return DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(date.toLocal());
  }

  String _getTranslatedEntry(BuildContext context) {
    final value = attribute.value.toJson()['value'].toString();
    final translation = attribute.valueHints.getTranslation(value);
    if (translation.startsWith('i18n://')) return FlutterI18n.translate(context, translation.substring(7));

    return value;
  }
}
