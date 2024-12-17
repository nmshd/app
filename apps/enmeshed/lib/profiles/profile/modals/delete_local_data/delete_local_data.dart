import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
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
  bool get _canDelete => false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: MediaQuery.viewPaddingOf(context).bottom + 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Are you sure you want to delete all local data?'),
          ),
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

  void _delete() {
    if (!_canDelete) return;
  }
}
