import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class SavingProfile extends StatelessWidget {
  const SavingProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.paddingOf(context).bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.l10n.profile_edit_inProgress, style: Theme.of(context).textTheme.headlineSmall),
            Gaps.h24,
            const SizedBox(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
