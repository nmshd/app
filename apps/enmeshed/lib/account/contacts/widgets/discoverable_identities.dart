import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/core.dart';

class DiscoverableIdentities extends StatelessWidget {
  final String accountId;
  final List<PublicRelationshipTemplateReferenceDTO> publicRelationshipTemplateReferences;

  const DiscoverableIdentities({
    required this.accountId,
    required this.publicRelationshipTemplateReferences,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(context.l10n.contacts_selectedForYou, style: Theme.of(context).textTheme.titleMedium),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: SizedBox(
            height: 100 + 16,
            child: CarouselView(
              itemExtent: 138 + 16,
              shrinkExtent: 138 + 16,
              padding: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              onTap: (index) async {
                final reference = publicRelationshipTemplateReferences[index];

                final runtime = GetIt.I.get<EnmeshedRuntime>();
                final account = await runtime.accountServices.getAccount(accountId);

                await runtime.stringProcessor.processTruncatedReference(truncatedReference: reference.truncatedReference, account: account);
              },
              children: publicRelationshipTemplateReferences.map((reference) => _DiscoverableIdentity(reference: reference)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _DiscoverableIdentity extends StatelessWidget {
  final PublicRelationshipTemplateReferenceDTO reference;

  const _DiscoverableIdentity({required this.reference});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: context.customColors.decorative,
            child: Text(
              _contactNameLetters(reference.title),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15, color: context.customColors.onDecorative),
            ),
          ),
          Spacer(),
          Text(
            reference.title,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(height: 1),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  String _contactNameLetters(String contactName) {
    if (contactName.length <= 2) return contactName;

    final splitted = contactName.split(RegExp('[ -]+')).where((e) => e.isNotEmpty).toList();
    if (splitted.length > 1) {
      return splitted[0].substring(0, 1) + splitted[1].substring(0, 1);
    }

    return contactName.substring(0, 2);
  }
}
