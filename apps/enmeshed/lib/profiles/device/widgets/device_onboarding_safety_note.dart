import 'package:flutter/material.dart';

import '/core/core.dart';

class DeviceOnboardingSafetyNote extends StatelessWidget {
  final VoidCallback goToNextPage;

  const DeviceOnboardingSafetyNote({required this.goToNextPage, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, left: 24, right: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
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
              child: Text(context.l10n.qrSafetyInformation),
            ),
          ),
          Gaps.h16,
          Text(context.l10n.qrSafetyInformation_preparation),
          Gaps.h16,
          Row(
            children: [
              Icon(Icons.verified_user, color: Theme.of(context).colorScheme.primary),
              Gaps.w8,
              Flexible(child: Text(context.l10n.qrSafetyInformation_environment)),
            ],
          ),
          Gaps.h16,
          Row(
            children: [
              Icon(Icons.verified_user, color: Theme.of(context).colorScheme.primary),
              Gaps.w8,
              Flexible(child: Text(context.l10n.qrSafetyInformation_access)),
            ],
          ),
          Gaps.h32,
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: goToNextPage,
              style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
              child: Text(context.l10n.qrSafetyInformation_show),
            ),
          ),
        ],
      ),
    );
  }
}
