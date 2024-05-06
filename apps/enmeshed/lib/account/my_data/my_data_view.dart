import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class MyDataView extends StatefulWidget {
  final String accountId;

  const MyDataView({required this.accountId, super.key});

  @override
  State<MyDataView> createState() => _MyDataViewState();
}

class _MyDataViewState extends State<MyDataView> {
  late final List<StreamSubscription<void>> _subscriptions = [];

  LocalAccountDTO? _account;
  bool _personalDataExisting = true;
  bool _addressDataExisting = true;
  bool _communicationDataExisting = true;

  @override
  void initState() {
    super.initState();

    _reload();

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions
      ..add(runtime.eventBus.on<AccountSelectedEvent>().listen((_) => _reload().catchError((_) {})))
      ..add(runtime.eventBus.on<AttributeCreatedEvent>().listen((_) => _reload().catchError((_) {})));
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: AutoLoadingProfilePicture(
            accountId: widget.accountId,
            profileName: _account?.name ?? '',
            circleAvatarColor: context.customColors.decorativeContainer!,
            radius: 80,
          ),
        ),
        Gaps.h8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _account?.name ?? '',
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        Gaps.h32,
        ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.co_present_outlined),
                title: Text(context.l10n.myData_allData),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/account/${widget.accountId}/my-data/all-data'),
              ),
              const Divider(indent: 16, height: 2),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: Text(context.l10n.myData_personalData),
                trailing: !_personalDataExisting
                    ? TextButton.icon(
                        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
                        onPressed: () => context.push('/account/${widget.accountId}/my-data/initial-personalData-creation'),
                        label: Text(context.l10n.myData_initialCreation),
                        icon: const Icon(Icons.add),
                      )
                    : const Icon(Icons.chevron_right),
                onTap: !_personalDataExisting ? null : () => context.push('/account/${widget.accountId}/my-data/personal-data'),
              ),
              const Divider(indent: 16, height: 2),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(context.l10n.myData_addressData),
                trailing: !_addressDataExisting
                    ? TextButton.icon(
                        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
                        onPressed: () => context.push('/account/${widget.accountId}/my-data/initial-addressData-creation'),
                        label: Text(context.l10n.myData_initialCreation),
                        icon: const Icon(Icons.add),
                      )
                    : const Icon(Icons.chevron_right),
                onTap: !_addressDataExisting ? null : () => context.push('/account/${widget.accountId}/my-data/address-data'),
              ),
              const Divider(indent: 16, height: 2),
              ListTile(
                leading: const Icon(Icons.forum),
                title: Text(context.l10n.myData_communicationData),
                trailing: !_communicationDataExisting
                    ? TextButton.icon(
                        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
                        onPressed: () => context.push('/account/${widget.accountId}/my-data/initial-communicationData-creation'),
                        label: Text(context.l10n.myData_initialCreation),
                        icon: const Icon(Icons.add),
                      )
                    : const Icon(Icons.chevron_right),
                onTap: !_communicationDataExisting ? null : () => context.push('/account/${widget.accountId}/my-data/communication-data'),
              ),
              const Divider(indent: 16, height: 2),
              ListTile(
                leading: const Icon(Icons.folder),
                title: Text(context.l10n.files),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/account/${widget.accountId}/my-data/files'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _reload() async {
    final account = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccount(widget.accountId);

    if (mounted) {
      setState(() {
        _account = account;
      });
    }

    await _updateDataExisting();
  }

  Future<void> _updateDataExisting() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    final existingData = await getDataExisting(session);

    if (mounted) {
      setState(() {
        _personalDataExisting = existingData.personalData;
        _addressDataExisting = existingData.addressData;
        _communicationDataExisting = existingData.communicationData;
      });
    }
  }
}
