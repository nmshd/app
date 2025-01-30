import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../utils/utils.dart';

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

class _RestoreIdentity extends StatefulWidget {
  final LocalAccountDTO accountInDeletion;
  final String deletionDate;

  const _RestoreIdentity({
    required this.accountInDeletion,
    required this.deletionDate,
  });

  @override
  State<_RestoreIdentity> createState() => _RestoreIdentityState();
}

class _RestoreIdentityState extends State<_RestoreIdentity> {
  bool _isRestoring = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isRestoring,
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.viewPaddingOf(context).bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VectorGraphic(loader: AssetBytesLoader('assets/svg/restore_identity.svg'), height: 160),
            Gaps.h24,
            Text(context.l10n.identity_reactivate_description(widget.accountInDeletion.name, DateTime.parse(widget.deletionDate).toLocal())),
            Gaps.h8,
            Align(alignment: Alignment.centerLeft, child: Text(context.l10n.identity_restore_description)),
            Gaps.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: _isRestoring ? null : context.pop, child: Text(context.l10n.identity_restore_cancel)),
                Gaps.w8,
                FilledButton(onPressed: _isRestoring ? null : _restore, child: Text(context.l10n.identity_restore_confirm)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _restore() async {
    if (_isRestoring) return;

    setState(() => _isRestoring = true);

    await cancelIdentityDeletionProcess(context, widget.accountInDeletion);
  }
}
