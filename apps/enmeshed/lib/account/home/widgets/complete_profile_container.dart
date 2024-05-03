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
  bool _isAddressDataStored = false;
  bool _isCommunicationDataStored = false;

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
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InfoContainer(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: CompleteProfileHeader(
                    count: 4,
                    countCompleted: [true, _isPersonalDataStored, _isAddressDataStored, _isCommunicationDataStored].where((e) => e).length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4, top: 4),
                  child: IconButton(onPressed: widget.hideContainer, icon: const Icon(Icons.close)),
                ),
              ],
            ),
            Gaps.h8,
            _TodoListTile.alwaysChecked(text: context.l10n.home_profileCreated),
            _TodoListTile(
              done: _isPersonalDataStored,
              text: context.l10n.home_personalInformationStored,
              number: 2,
              onPressed: () => context.push('/account/${widget.accountId}/my-data/initial-personalData-creation'),
            ),
            _TodoListTile(
              done: _isAddressDataStored,
              number: 3,
              text: context.l10n.home_addressInformationStored,
              onPressed: () => context.push('/account/${widget.accountId}/my-data/initial-addressData-creation'),
            ),
            _TodoListTile(
              done: _isCommunicationDataStored,
              number: 4,
              text: context.l10n.home_communicationInformationStored,
              onPressed: () => context.push('/account/${widget.accountId}/my-data/initial-communicationData-creation'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reload() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final existingData = await getDataExisting(session);

    if (mounted) {
      setState(() {
        _isPersonalDataStored = existingData.personalData;
        _isAddressDataStored = existingData.addressData;
        _isCommunicationDataStored = existingData.communicationData;
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
        contentPadding: const EdgeInsets.only(left: 16),
        leading: Icon(Icons.check_circle_rounded, size: 36, color: Theme.of(context).colorScheme.primary),
        title: Text(text),
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
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
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.home_completeProfile, style: Theme.of(context).textTheme.titleMedium),
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
        border: Border.all(color: Theme.of(context).colorScheme.surfaceVariant, width: 2),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outline),
        ),
      ),
    );
  }
}
