import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';
import 'deletion_type.dart';

class DeletingProfile extends StatefulWidget {
  final Session session;
  final LocalAccountDTO localAccount;
  final DeletionType deletionType;
  final String inProgressText;

  const DeletingProfile({required this.session, required this.localAccount, required this.deletionType, required this.inProgressText, super.key});

  @override
  State<DeletingProfile> createState() => _DeletingProfileState();
}

class _DeletingProfileState extends State<DeletingProfile> {
  Exception? _exception;

  @override
  void initState() {
    super.initState();

    unawaited(_runDeletion());
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalCloseable(
      canClose: false,
      child: switch (_exception) {
        Exception() => _Error(onRetry: _runDeletion),
        _ => ModalLoadingOverlay(text: widget.inProgressText, expand: false, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48)),
      },
    );
  }

  Future<void> _runDeletion() async {
    switch (widget.deletionType) {
      case DeletionType.identity:
        await _runIdentityDeletion();
      case DeletionType.profile:
        await _runProfileDeletion();
    }
  }

  Future<void> _runIdentityDeletion() async {
    final result = await widget.session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();

    if (result.isError) {
      GetIt.I.get<Logger>().e('Failed to delete account ${result.error.message}');
      setState(() => _exception = Exception('Failed to delete account'));

      return;
    }

    await _onDeletionSuccessful();
  }

  Future<void> _runProfileDeletion() async {
    try {
      await GetIt.I.get<EnmeshedRuntime>().accountServices.offboardAccount(widget.localAccount.id);
      await _onDeletionSuccessful();
    } catch (e) {
      GetIt.I.get<Logger>().e('Failed to delete account $e');
      setState(() => _exception = Exception('Failed to delete profile'));
    }
  }

  Future<void> _onDeletionSuccessful() async {
    final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccountsNotInDeletion();
    accounts.sort((a, b) => a.name.compareTo(b.name));

    if (!mounted) return;

    showSuccessSnackbar(
      context: context,
      text: switch (widget.deletionType) {
        DeletionType.profile => context.l10n.profile_delete_success(widget.localAccount.name),
        DeletionType.identity => context.l10n.identity_delete_success(widget.localAccount.name),
      },
    );

    if (accounts.isEmpty) {
      context.go('/onboarding?skipIntroduction=true');
      return;
    }

    final account = accounts.first;

    context.go('/account/${account.id}');
    await context.push('/profiles');

    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);
  }
}

class _Error extends StatelessWidget {
  final VoidCallback onRetry;

  const _Error({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.viewPaddingOf(context).bottom + 24),
      child: Column(
        children: [
          Icon(Icons.cancel, size: 160, color: Theme.of(context).colorScheme.error),
          Gaps.h24,
          Text(context.l10n.profile_delete_error, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              alignment: WrapAlignment.end,
              runAlignment: WrapAlignment.spaceBetween,
              spacing: 8,
              children: [
                OutlinedButton(onPressed: context.pop, child: Text(context.l10n.profile_delete_error_cancel)),
                FilledButton(onPressed: onRetry, child: Text(context.l10n.profile_delete_error_retry)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
