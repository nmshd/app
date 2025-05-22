import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class DrawerHintsPage extends StatefulWidget {
  final String accountId;
  final VoidCallback goBack;

  const DrawerHintsPage({required this.accountId, required this.goBack, super.key});

  @override
  State<DrawerHintsPage> createState() => DrawerHintsPageState();
}

class DrawerHintsPageState extends State<DrawerHintsPage> {
  bool? _firstSteps;
  bool? _addContact;
  bool? _loadProfile;

  late final StreamSubscription<void> _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = GetIt.I.get<EnmeshedRuntime>().eventBus.on<DatawalletSynchronizedEvent>().listen((_) => _loadHints().catchError((_) {}));

    _loadHints();
  }

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = Row(
      children: [
        IconButton(icon: const Icon(Icons.arrow_back), onPressed: widget.goBack),
        Text(
          context.l10n.drawer_hints,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        const Spacer(),
        IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
      ],
    );

    if (_firstSteps == null || _addContact == null || _loadProfile == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          const Center(child: CircularProgressIndicator()),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), child: Text(context.l10n.drawer_hints_description)),
        Gaps.h24,
        SwitchListTile(
          title: Text(context.l10n.drawer_hints_loadProfile, style: Theme.of(context).textTheme.labelLarge),
          value: _loadProfile!,
          onChanged: (value) async {
            await upsertHintsSetting(accountId: widget.accountId, key: 'hints.${ScannerType.loadProfile}', value: value);
            setState(() => _loadProfile = value);
          },
        ),
        SwitchListTile(
          title: Text(context.l10n.drawer_hints_addContact, style: Theme.of(context).textTheme.labelLarge),
          value: _addContact!,
          onChanged: (value) async {
            await upsertHintsSetting(accountId: widget.accountId, key: 'hints.${ScannerType.addContact}', value: value);
            setState(() => _addContact = value);
          },
        ),
        SwitchListTile(
          title: Text(context.l10n.drawer_hints_firstSteps, style: Theme.of(context).textTheme.labelLarge),
          value: _firstSteps!,
          onChanged: (value) async {
            await upsertCompleteProfileContainerSetting(value: value, accountId: widget.accountId);
            setState(() => _firstSteps = value);
          },
        ),
      ],
    );
  }

  Future<void> _loadHints() async {
    final firstSteps = await getSetting(accountId: widget.accountId, key: 'home.completeProfileContainerShown', valueKey: 'isShown');
    final addContact = await getSetting(accountId: widget.accountId, key: 'hints.${ScannerType.addContact}', valueKey: 'showHints');
    final loadProfile = await getSetting(accountId: widget.accountId, key: 'hints.${ScannerType.loadProfile}', valueKey: 'showHints');

    setState(() {
      _firstSteps = firstSteps;
      _addContact = addContact;
      _loadProfile = loadProfile;
    });
  }
}
