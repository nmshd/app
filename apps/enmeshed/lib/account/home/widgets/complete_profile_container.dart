import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class CompleteProfileContainer extends StatefulWidget {
  final VoidCallback hideContainer;
  final String accountId;

  const CompleteProfileContainer({required this.hideContainer, required this.accountId, super.key});

  @override
  State<CompleteProfileContainer> createState() => _CompleteProfileContainerState();
}

class _CompleteProfileContainerState extends State<CompleteProfileContainer> {
  final List<StreamSubscription<void>> _subscriptions = [];

  bool _isPersonalDataStored = false;
  bool _hasRelationship = false;
  bool _isFileDataStored = false;
  bool _createdIdentityRecoveryKit = false;

  @override
  void initState() {
    super.initState();

    final eventBus = GetIt.I.get<EnmeshedRuntime>().eventBus;
    _subscriptions
      ..add(eventBus.on<DatawalletSynchronizedEvent>().listen((_) => _reload()))
      ..add(eventBus.on<AccountSelectedEvent>().listen((_) => _reload()));
    _reload();
  }

  @override
  void didUpdateWidget(covariant CompleteProfileContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.accountId != widget.accountId) {
      _reload();
    }
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: _CompleteProfileHeader(
                  count: 4,
                  countCompleted: [_isPersonalDataStored, _hasRelationship, _isFileDataStored, _createdIdentityRecoveryKit].where((e) => e).length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4, top: 8),
                child: IconButton(
                  onPressed: widget.hideContainer,
                  icon: Icon(Icons.close, semanticLabel: context.l10n.home_completeProfileCloseIconSemanticsLabel),
                ),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Text(context.l10n.home_completeProfileDescription)),
          _TodoListTile(
            done: _isPersonalDataStored,
            text: context.l10n.home_initialPersonalInformation,
            onPressed: () => context.push('/account/${widget.accountId}/my-data/initial-personalData-creation'),
          ),
          _TodoListTile(
            done: _hasRelationship,
            text: context.l10n.home_initialContact,
            onPressed: () => goToInstructionsOrScanScreen(accountId: widget.accountId, instructionsType: ScannerType.addContact, context: context),
          ),
          _TodoListTile(
            done: _isFileDataStored,
            text: context.l10n.home_initialDocuments,
            onPressed: () async {
              await context.push('/account/${widget.accountId}/my-data/files?initialCreation=true');
              await _reload();
            },
          ),
          _TodoListTile(
            done: _createdIdentityRecoveryKit,
            text: context.l10n.home_createIdentityRecoveryKit,
            onPressed: () async {
              await context.push('/account/${widget.accountId}/create-identity-recovery-kit');
              await _reload();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _reload() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final existingData = await getDataExisting(session);
    final relationships = await getContacts(session: session);
    final filesResult = await session.transportServices.files.getFiles();
    final existingIdentityRecoveryKitResult = await session.transportServices.identityRecoveryKits.checkForExistingIdentityRecoveryKit();

    if (mounted) {
      setState(() {
        _isPersonalDataStored = existingData.personalData;
        _hasRelationship = relationships.isNotEmpty;
        _isFileDataStored = filesResult.value.isNotEmpty;
        _createdIdentityRecoveryKit = existingIdentityRecoveryKitResult.value.exists;
      });
    }
  }
}

class _TodoListTile extends StatelessWidget {
  final bool done;
  final String text;
  final void Function() onPressed;

  const _TodoListTile({required this.done, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(text),
      trailing: done ? const CustomSuccessIcon(containerSize: 24, iconSize: 20) : const Icon(Icons.chevron_right),
      onTap: done ? null : onPressed,
    );
  }
}

class _CompleteProfileHeader extends StatelessWidget {
  final int count;
  final int countCompleted;

  const _CompleteProfileHeader({required this.count, required this.countCompleted});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.home_completeProfile, style: Theme.of(context).textTheme.titleLarge),
            Gaps.h8,
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.labelSmall,
                children: [
                  TextSpan(
                    text: '$countCompleted ${context.l10n.home_of} $count ',
                    style: TextStyle(color: count == countCompleted ? context.customColors.success : Theme.of(context).colorScheme.primary),
                  ),
                  TextSpan(text: context.l10n.home_completed),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
