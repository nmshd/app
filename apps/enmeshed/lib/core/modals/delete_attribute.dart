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

import '../utils/extensions.dart';

Future<void> showDeleteAttributeModal({
  required BuildContext context,
  required String accountId,
  required LocalAttributeDVO attribute,
  required VoidCallback onAttributeDeleted,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    builder: (context) => _DeleteConfirmation(
      accountId: accountId,
      onAttributeDeleted: onAttributeDeleted,
      attribute: attribute as RepositoryAttributeDVO,
    ),
  );
}

class _DeleteConfirmation extends StatefulWidget {
  final String accountId;
  final VoidCallback onAttributeDeleted;
  final RepositoryAttributeDVO attribute;

  const _DeleteConfirmation({
    required this.accountId,
    required this.onAttributeDeleted,
    required this.attribute,
  });

  @override
  State<_DeleteConfirmation> createState() => _DeleteConfirmationState();
}

class _DeleteConfirmationState extends State<_DeleteConfirmation> {
  bool _deleting = false;

  @override
  Widget build(BuildContext context) {
    final isShared = widget.attribute.sharedWith.isNotEmpty;

    return ConditionalCloseable(
      canClose: !_deleting,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(
            title: context.l10n.personalData_details_deleteEntry,
            canClose: !_deleting,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Align(
              alignment: Alignment.topCenter,
              child: VectorGraphic(loader: AssetBytesLoader('assets/svg/attribute_deletion.svg'), height: 136),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: isShared
                ? BoltStyledText(
                    context.l10n.personalData_details_deleteDescriptionShared(
                      widget.attribute.sharedWith.length,
                      _getDisplayValue(context, widget.attribute.value),
                    ),
                  )
                : BoltStyledText(context.l10n.personalData_details_deleteDescription(_getDisplayValue(context, widget.attribute.value))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24).add(EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: _deleting ? null : context.pop,
                  child: Text(context.l10n.personalData_details_cancelDeletion),
                ),
                Gaps.w8,
                FilledButton(
                  onPressed: _deleting ? null : _deleteAttributeAndNotifyPeers,
                  child: Text(context.l10n.personalData_details_confirmAttributeDeletion),
                ),
              ],
            ),
          ),
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
    final value = widget.attribute.value.toJson()['value'].toString();
    final translation = widget.attribute.valueHints.getTranslation(value);
    if (translation.startsWith('i18n://')) return FlutterI18n.translate(context, translation.substring(7));

    return value;
  }

  Future<void> _deleteAttributeAndNotifyPeers() async {
    if (_deleting) return;

    setState(() => _deleting = true);

    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);

    for (final sharedToPeerAttribute in widget.attribute.sharedWith) {
      final deleteAttributeResult = await session.consumptionServices.attributes.deleteOwnSharedAttributeAndNotifyPeer(
        attributeId: sharedToPeerAttribute.id,
      );
      if (deleteAttributeResult.isError) {
        GetIt.I.get<Logger>().e('Deleting shared attribute failed caused by: ${deleteAttributeResult.error}');
      }
    }

    final deleteAttributeResult = await session.consumptionServices.attributes.deleteRepositoryAttribute(attributeId: widget.attribute.id);

    if (deleteAttributeResult.isError) {
      GetIt.I.get<Logger>().e('Deleting attribute failed caused by: ${deleteAttributeResult.error}');

      if (mounted) {
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

      setState(() => _deleting = false);

      return;
    }

    widget.onAttributeDeleted();

    if (mounted) context.pop();
  }
}
