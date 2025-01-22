import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';

Future<void> showRestoreIdentityModal({required LocalAccountDTO accountInDeletion, required BuildContext context}) async {
  if (!context.mounted) return;

  assert(accountInDeletion.deletionDate != null, 'Account deletion date must not be null');

  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: false,
    builder: (context) => _RestoreIdentity(
      accountInDeletion: accountInDeletion,
      deletionDate: accountInDeletion.deletionDate!,
    ),
  );
}

class _RestoreIdentity extends StatelessWidget {
  final LocalAccountDTO accountInDeletion;
  final String deletionDate;

  const _RestoreIdentity({
    required this.accountInDeletion,
    required this.deletionDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewPaddingOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const VectorGraphic(loader: AssetBytesLoader('assets/svg/restore_identity.svg'), height: 160),
          Gaps.h24,
          Text(context.l10n.identity_reactivate_description(accountInDeletion.name, DateTime.parse(deletionDate).toLocal())),
          Gaps.h8,
          Align(alignment: Alignment.centerLeft, child: Text(context.l10n.identity_restore_description)),
          Gaps.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: context.pop, child: Text(context.l10n.identity_restore_cancel)),
              Gaps.w8,
              FilledButton(
                onPressed: () => cancelIdentityDeletionProcess(context, accountInDeletion),
                child: Text(context.l10n.identity_restore_confirm),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
