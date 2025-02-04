import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '/core/core.dart';

class DeleteProfileAndChooseNext extends StatefulWidget {
  final LocalAccountDTO localAccount;
  final ValueNotifier<Future<Result<dynamic>>?> deleteFuture;
  final ValueNotifier<Future<Result<dynamic>> Function()?> retryFunction;
  final ValueNotifier<void Function(BuildContext)?> notifyDeletion;
  final String inProgressText;

  const DeleteProfileAndChooseNext({
    required this.localAccount,
    required this.deleteFuture,
    required this.retryFunction,
    required this.notifyDeletion,
    required this.inProgressText,
    super.key,
  });

  @override
  State<DeleteProfileAndChooseNext> createState() => _DeleteProfileAndChooseNextState();
}

class _DeleteProfileAndChooseNextState extends State<DeleteProfileAndChooseNext> {
  Exception? _exception;

  @override
  void initState() {
    super.initState();

    if (widget.deleteFuture.value != null) {
      _handleFuture(widget.deleteFuture.value!);
    } else {
      widget.deleteFuture.addListener(() {
        _handleFuture(widget.deleteFuture.value!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalCloseable(
      canClose: false,
      child: switch (_exception) {
        Exception() => _Error(
            onRetry: () async {
              if (widget.retryFunction.value == null) return;

              setState(() => _exception = null);

              await _handleFuture(widget.retryFunction.value!());
            },
          ),
        _ => _Loading(inProgressText: widget.inProgressText),
      },
    );
  }

  Future<void> _handleFuture(Future<Result<dynamic>> future) async => future.then((r) {
        if (r.isError) {
          GetIt.I.get<Logger>().e('Failed to delete account ${r.error.message}');
          setState(() => _exception = Exception('Failed to delete account'));

          return;
        }

        _onProfileDeleted();
      }).onError(
        (error, stackTrace) {
          GetIt.I.get<Logger>().e('Failed to delete account $error');
          setState(() => _exception = Exception('Failed to delete account'));
        },
      );

  Future<void> _onProfileDeleted() async {
    final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccountsNotInDeletion();

    accounts.sort((a, b) => a.name.compareTo(b.name));

    if (!mounted) return;

    widget.notifyDeletion.value?.call(context);

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
          Text(
            context.l10n.profile_delete_error,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              alignment: WrapAlignment.end,
              runAlignment: WrapAlignment.spaceBetween,
              spacing: 8,
              children: [
                OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.profile_delete_error_cancel)),
                FilledButton(onPressed: onRetry, child: Text(context.l10n.profile_delete_error_retry)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  final String inProgressText;

  const _Loading({required this.inProgressText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 60, bottom: MediaQuery.viewPaddingOf(context).bottom + 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(inProgressText, style: Theme.of(context).textTheme.headlineSmall),
            Gaps.h24,
            const SizedBox(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
