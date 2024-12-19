import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';
import 'info_container.dart';

class AddContactOrDeviceContainer extends StatelessWidget {
  final String accountId;

  const AddContactOrDeviceContainer({required this.accountId, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.home_scanQR, style: Theme.of(context).textTheme.titleLarge),
        Gaps.h8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _AddContact(accountId: accountId),
            Gaps.w16,
            _AddDevice(accountId: accountId),
          ],
        ),
      ],
    );
  }
}

class _AddDevice extends StatelessWidget {
  final String accountId;

  const _AddDevice({required this.accountId});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => goToInstructionsOrScanScreen(accountId: accountId, instructionsType: ScannerType.loadProfile, context: context),
        child: InfoContainer(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VectorGraphic(
                loader: const AssetBytesLoader('assets/svg/load_profile.svg'),
                height: 112,
                semanticsLabel: context.l10n.home_loadProfileImageSemanticsLabel,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  context.l10n.home_loadProfile,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddContact extends StatelessWidget {
  final String accountId;

  const _AddContact({required this.accountId});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => goToInstructionsOrScanScreen(accountId: accountId, instructionsType: ScannerType.addContact, context: context),
        child: InfoContainer(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VectorGraphic(
                loader: const AssetBytesLoader('assets/svg/add_contact.svg'),
                height: 112,
                semanticsLabel: context.l10n.home_addContactImageSemanticsLabel,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  context.l10n.home_addContact,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
