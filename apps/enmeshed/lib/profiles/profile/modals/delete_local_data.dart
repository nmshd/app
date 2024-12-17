import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

Future<void> showDeleteLocalDataModal({
  required BuildContext context,
  required List<LocalAccountDTO> accountsInDeletion,
  required VoidCallback onDeleted,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => _DeleteLocalDataModal(accountsInDeletion: accountsInDeletion, onDeleted: onDeleted),
  );
}

class _DeleteLocalDataModal extends StatefulWidget {
  final List<LocalAccountDTO> accountsInDeletion;
  final VoidCallback onDeleted;

  const _DeleteLocalDataModal({required this.accountsInDeletion, required this.onDeleted});

  @override
  State<_DeleteLocalDataModal> createState() => __DeleteLocalDataModalState();
}

class __DeleteLocalDataModalState extends State<_DeleteLocalDataModal> {
  bool get _canDelete => true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: MediaQuery.viewPaddingOf(context).bottom + 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Are you sure you want to delete all local data?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: context.pop, child: Text(context.l10n.cancel)),
              Gaps.w8,
              FilledButton(onPressed: _canDelete ? _delete : null, child: const Text('Daten löschen')),
            ],
          ),
        ],
      ),
    );
  }

  void _delete() async {
    if (!_canDelete) return;

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    for (final account in widget.accountsInDeletion) {
      await runtime.accountServices.offboardAccount(account.id);
    }

    widget.onDeleted();
    if (mounted) context.pop();
  }
}
