import 'package:flutter/material.dart';

import '/core/core.dart';

class DeviceOnboardingSafetyNote extends StatelessWidget {
  final VoidCallback goToNextPage;

  const DeviceOnboardingSafetyNote({required this.goToNextPage, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewPaddingOf(context).bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.security, color: Theme.of(context).colorScheme.secondary, size: 40),
                  Gaps.w8,
                  Expanded(child: Text(context.l10n.qrSafetyInformation)),
                ],
              ),
            ),
          ),
          Gaps.h32,
          Text(context.l10n.qrSafetyInformation_preparation),
          Gaps.h12,
          Row(
            children: [
              Icon(Icons.verified_user, color: Theme.of(context).colorScheme.primary),
              Gaps.w8,
              Flexible(child: Text(context.l10n.qrSafetyInformation_environment)),
            ],
          ),
          Gaps.h12,
          Row(
            children: [
              Icon(Icons.verified_user, color: Theme.of(context).colorScheme.primary),
              Gaps.w8,
              Flexible(child: Text(context.l10n.qrSafetyInformation_access)),
            ],
          ),
          Gaps.h40,
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: goToNextPage,
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24)),
              child: Text(context.l10n.qrSafetyInformation_show),
            ),
          ),
        ],
      ),
    );
  }
}
