import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class DeviceOnboardingSafetyNote extends StatelessWidget {
  final VoidCallback goToNextPage;

  const DeviceOnboardingSafetyNote({required this.goToNextPage, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomSheetHeader(title: context.l10n.safetyInformation),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewPaddingOf(context).bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InformationCard(title: context.l10n.qrSafetyInformation, backgroundColor: Theme.of(context).colorScheme.primaryContainer),
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
              Gaps.h32,
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FilledButton(
                    onPressed: goToNextPage,
                    style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24)),
                    child: Text(context.l10n.qrSafetyInformation_show),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
