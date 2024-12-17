import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../constants.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

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
  State<_DeleteLocalDataModal> createState() => _DeleteLocalDataModalState();
}

class _DeleteLocalDataModalState extends State<_DeleteLocalDataModal> {
  final Set<LocalAccountDTO> _selectedAccounts = {};

  @override
  void initState() {
    super.initState();

    if (widget.accountsInDeletion.length == 1) {
      _selectedAccounts.add(widget.accountsInDeletion.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.profile_localDeletion_title, style: Theme.of(context).textTheme.titleLarge),
                IconButton(icon: const Icon(Icons.close), onPressed: context.pop),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: VectorGraphic(loader: AssetBytesLoader('assets/svg/confirm_local_data_deletion.svg'), height: 160),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: Text(context.l10n.profile_localDeletion_selectProfiles),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: Column(
                      spacing: 12,
                      children: [
                        for (final account in widget.accountsInDeletion)
                          DeletionProfileCard(
                            accountInDeletion: account,
                            leading: (widget.accountsInDeletion.length < 2)
                                ? null
                                : Checkbox(
                                    value: _selectedAccounts.contains(account),
                                    onChanged: (value) => setState(() => _selectedAccounts.toggle(account))),
                            onTap: () => setState(() => _selectedAccounts.toggle(account)),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.viewPaddingOf(context).bottom + 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: context.pop, child: Text(context.l10n.cancel)),
                Gaps.w8,
                FilledButton(
                    onPressed: _selectedAccounts.isNotEmpty ? _delete : null, child: Text(context.l10n.profile_localDeletion_acceptDeletion)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _delete() async {
    if (!_selectedAccounts.isNotEmpty) return;

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    for (final account in _selectedAccounts) {
      await runtime.accountServices.offboardAccount(account.id);
    }

    widget.onDeleted.call();
    if (mounted) context.pop();
  }
}
