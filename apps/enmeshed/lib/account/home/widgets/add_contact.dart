import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';

class AddContact extends StatelessWidget {
  final String accountId;

  const AddContact({required this.accountId, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: InkWell(
          onTap: () => goToInstructionsOrScanScreen(accountId: accountId, instructionsType: ScannerType.addContact, context: context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                VectorGraphic(
                  loader: const AssetBytesLoader('assets/svg/add_contact.svg'),
                  height: 54,
                  semanticsLabel: context.l10n.home_addContactImageSemanticsLabel,
                ),
                Text(
                  context.l10n.home_addContact,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
