import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'info_container.dart';

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
    return InfoContainer(
      padding: const EdgeInsets.only(bottom: 8, left: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompleteProfileHeader(
                count: 4,
                countCompleted: [true, _isPersonalDataStored, _hasRelationship, _isFileDataStored].where((e) => e).length,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 16),
                child: IconButton(
                  onPressed: widget.hideContainer,
                  icon: Icon(Icons.close, semanticLabel: context.l10n.home_completeProfileCloseIconSemanticsLabel),
                ),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.only(right: 24, top: 12, bottom: 12), child: Text(context.l10n.home_completeProfileDescription)),
          _TodoListTile.alwaysChecked(text: context.l10n.home_createProfile),
          _TodoListTile(
            done: _isPersonalDataStored,
            text: context.l10n.home_initialPersonalInformation,
            number: 2,
            onPressed: () => context.push('/account/${widget.accountId}/my-data/initial-personalData-creation'),
          ),
          _TodoListTile(
            done: _hasRelationship,
            number: 3,
            text: context.l10n.home_initialContact,
            onPressed: () => goToInstructionsOrScanScreen(
              accountId: widget.accountId,
              instructionsType: InstructionsType.addContact,
              context: context,
            ),
          ),
          _TodoListTile(
            done: _isFileDataStored,
            number: 4,
            text: context.l10n.home_initialDocuments,
            onPressed: () async {
              await context.push('/account/${widget.accountId}/my-data/files?initialCreation=true');
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

    if (mounted) {
      setState(() {
        _isPersonalDataStored = existingData.personalData;
        _hasRelationship = relationships.isNotEmpty;
        _isFileDataStored = filesResult.value.isNotEmpty;
      });
    }
  }
}

class _TodoListTile extends StatelessWidget {
  final bool done;
  final int number;

  final String text;

  final void Function()? onPressed;

  const _TodoListTile({
    required this.done,
    required this.number,
    required this.text,
    required this.onPressed,
  });

  const _TodoListTile.alwaysChecked({required this.text})
      : done = true,
        onPressed = null,
        number = 0;

  @override
  Widget build(BuildContext context) {
    if (done) {
      return ListTile(
        contentPadding: const EdgeInsets.only(right: 16),
        leading: const CustomSuccessIcon(containerSize: 36, iconSize: 24),
        title: Text(text),
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.only(right: 16),
      leading: ToCompleteIcon(number: number),
      title: Text(text),
      trailing: const Icon(Icons.chevron_right),
      onTap: onPressed,
    );
  }
}

class CompleteProfileHeader extends StatelessWidget {
  final int count;
  final int countCompleted;

  const CompleteProfileHeader({required this.count, required this.countCompleted, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.home_completeProfile, style: Theme.of(context).textTheme.titleLarge),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: '$countCompleted ${context.l10n.home_of} $count ',
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    TextSpan(text: context.l10n.home_completed),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ToCompleteIcon extends StatelessWidget {
  final int number;

  const ToCompleteIcon({required this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
