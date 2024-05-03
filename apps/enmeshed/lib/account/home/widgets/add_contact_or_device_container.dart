import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
            _AddDevice(),
          ],
        ),
      ],
    );
  }
}

class _AddDevice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        // TODO(jkoenig134): go to an explanation page before
        onTap: () => context.push('/scan'),
        child: InfoContainer(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/load_profile.svg',
                semanticsLabel: context.l10n.home_loadProfileImageSemanticsLabel,
                height: 112,
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
        // TODO(jkoenig134): go to an explanation page before
        onTap: () => context.push('/account/$accountId/scan'),
        child: InfoContainer(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/add_contact.svg',
                semanticsLabel: context.l10n.home_addContactImageSemanticsLabel,
                height: 112,
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
